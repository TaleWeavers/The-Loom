extends Node

var ModPath:String
var AssetName:String

var Ore:bool = false
var Ingot:bool = false
var CrushedMetal:bool = false
var CrushedOre:bool = false
var Powder:bool = false
var Molten:bool = false
var MetalDecoBlocks:bool = false
var WoodDecoBlocks:bool = false

var hue = 1
var saturation: float = 1
var lightness: float = 1


#MainLine

func _on_mod_path_pressed() -> void:
	$CanvasLayer/Control/FileDialog.show()

func _on_file_dialog_dir_selected(dir: String) -> void:
	print("Selected Path:" + dir)
	ModPath = dir
	$CanvasLayer/Control/VBoxContainer/PathText.text = "Selected Path: " + dir

func _on_asset_name_text_changed(new_text: String) -> void:
	AssetName = new_text

func _on_build_pressed() -> void:
	if !ModPath.is_empty() and !AssetName.is_empty():
		print(ModPath, AssetName)
		#Build(Asset, "/home/civus/hytale-asset-generator/savegame.json")
		if Ore == true:
			ore_file_gen()
		if Ingot == true:
			ingot_file_gen()
		if CrushedMetal == true:
			crushed_metal_file_gen()
		if CrushedOre == true:
			crushed_ore_file_gen()
		if Powder == true:
			powder_file_gen()
		if Molten == true:
			Molten_file_gen()
		if MetalDecoBlocks == true:
			metal_deco_blocks_file_gen()
		if WoodDecoBlocks == true:
			wood_deco_blocks_file_gen()
	else:
		print("No Path or Name")
	pass # Replace with function body.

func _on_populate_path_button_down() -> void:
	if !ModPath.is_empty():
		PopulatePath.RunComb(ModPath)
	else:
		print("No Path?")


#Manifold

#Metals

func _on_ore_toggled(toggled_on: bool) -> void:
	Ore = toggled_on

func _on_ingot_toggled(toggled_on: bool) -> void:
	Ingot = toggled_on

func _on_crushed_metal_toggled(toggled_on: bool) -> void:
	CrushedMetal = toggled_on

func _on_crushed_ore_toggled(toggled_on: bool) -> void:
	CrushedOre = toggled_on

func _on_powder_toggled(toggled_on: bool) -> void:
	Powder = toggled_on

func _on_molten_toggled(toggled_on: bool) -> void:
	Molten = toggled_on

#Deco Blocks

func _on_metal_deco_blocks_toggled(toggled_on: bool) -> void:
	MetalDecoBlocks = toggled_on

func _on_wood_deco_blocks_toggled(toggled_on: bool) -> void:
	WoodDecoBlocks = toggled_on

#Liquid



#Build

#Metal

func ore_file_gen():
	pass

func ingot_file_gen():
	var file = FileAccess.open("res://BaseJSONs/Ingredient_Bar_Base.json", FileAccess.READ)
	if file == null:
		print("Error: Could not open file at ", "res://BaseJSONs/Ingredient_Bar_Base.json")
		return ""
	var content = file.get_as_text()
	file.close()
	
	var content2 = content.replace("Base", AssetName)
	var file2 = FileAccess.open(ModPath + "/Server/Item/Items/Ingredient/Bar/Ingredient_Bar_" + AssetName + ".json", FileAccess.WRITE)
	file2.store_string(content2)
	file2.close()
	generate_image("res://BaseImages/Base_Ingot.png", ModPath + "/Common/Resources/Materials/Ingot_Textures/" + AssetName + ".png")
	var lang = FileAccess.open(ModPath + "/Server/Languages/en-US/server.lang", FileAccess.READ_WRITE)
	lang.seek_end()
	lang.store_string("\nitems.Ingredient_Bar_"+AssetName+".name = "+AssetName+" Ingot")

func crushed_metal_file_gen():
	pass

func crushed_ore_file_gen():
	pass

func powder_file_gen():
	pass

func Molten_file_gen():
	pass

#Deco Blocks

func metal_deco_blocks_file_gen():
	pass

func wood_deco_blocks_file_gen():
	pass

#Liquid


#Color Selecter

func _on_h_slider_value_changed(value: float) -> void:
	hue = value
	update_image()

func _on_l_slider_value_changed(value: float) -> void:
	lightness = value
	update_image()

func _on_s_sliders_value_changed(value: float) -> void:
	saturation = value
	update_image()



func update_image():
	var img = Image.load_from_file("res://BaseImages/Base_Ingot.png")
	
	
	for x in img.get_width():
		for y in img.get_height():
			var pix_color: Color = img.get_pixel(x,y)
			var col_lightness: float = pix_color.ok_hsl_l * lightness
			#var col_saturation: float = pix_color.ok_hsl_s * saturation
			var col_saturation: float = saturation
			var adjusted_color: = Color.from_ok_hsl(hue, col_saturation, col_lightness, pix_color.a)
			img.set_pixel(x, y, adjusted_color)
			var imgtex = ImageTexture.create_from_image(img)
			$CanvasLayer/Control/VBoxContainer/HBoxContainer2/PanelContainer/ColorBase.set_texture(imgtex)

func generate_image(img_path: String, f_img_path: String):
	var img = Image.load_from_file(img_path)
	
	
	for x in img.get_width():
		for y in img.get_height():
			var pix_color: Color = img.get_pixel(x,y)
			var col_lightness: float = pix_color.ok_hsl_l * lightness
			#var col_saturation: float = pix_color.ok_hsl_s * saturation
			var col_saturation: float = saturation
			var adjusted_color: = Color.from_ok_hsl(hue, col_saturation, col_lightness, pix_color.a)
			img.set_pixel(x, y, adjusted_color)
	
	img.save_png(f_img_path)
	
