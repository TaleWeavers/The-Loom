extends Button

#var hue = 1
#var saturation: float = 1
#var lightness: float = 1

#func generate_image(img_path: String):
	#var img = Image.load_from_file(img_path)
	
	#for x in img.get_width():
		#for y in img.get_height():
			#var pix_color: Color = img.get_pixel(x,y)
			#var col_lightness: float = pix_color.ok_hsl_l * lightness
			#var col_saturation: float = pix_color.ok_hsl_s * saturation
			#var col_saturation: float = saturation
			#var adjusted_color: = Color.from_ok_hsl(hue, col_saturation, col_lightness, pix_color.a)
			#img.set_pixel(x, y, adjusted_color)
	
	#img.save_png("res://BaseImages/test.png")
	
	
	#var imgtex = ImageTexture.create_from_image(img)
	#var img2
	#$"../../../../Sprite2D".set_texture(imgtex)
	#$"../../../../Sprite2D".modulate = Color.from_hsv(hue,1,1)
	#var imgtex2 = $"../../../../Sprite2D".get_texture()
	#var mod = Color.from_hsv(hue,0.5,0.5)
	
	#img2 = imgtex2.get_image()
	#img2.fill(mod)
	#img.blend_rect(img2, Rect2i(Vector2i(-32,-32),Vector2i(500,500)), $"../../../../Sprite2D".position)
	#var imgfrmt = img.get_format()
	#print(imgfrmt)
	#var img2frmt = img2.get_format()
	#print(img2frmt)


#func _on_pressed() -> void:
	#generate_image()
