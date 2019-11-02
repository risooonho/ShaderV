tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVdistortion

func _get_name():
	return "DistortionUV"

func _get_category():
	return "UV"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Wave-like UV distortion"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 5

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "waveX"
		2:
			return "waveY"
		3:
			return "distortX"
		4:
			return "distortY"

func _get_input_port_type(port):
	set_input_port_default_value(1, 0)
	set_input_port_default_value(2, 0)
	set_input_port_default_value(3, 0)
	set_input_port_default_value(4, 0)
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "uv"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode):
	return """
vec2 d1stort1onUVFunc(vec2 _uv_d1st, float _d1stX_d1st, float _d1stY_d1st, float _waveX_d1st, float _waveY_d1st){
	_uv_d1st.x += sin(_uv_d1st.y * _waveX_d1st) * _d1stX_d1st;
	_uv_d1st.y += sin(_uv_d1st.x * _waveY_d1st) * _d1stY_d1st;
	return _uv_d1st;
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return "%s.xy = d1stort1onUVFunc(%s.xy, %s, %s, %s, %s);" % [
	output_vars[0], input_vars[0], input_vars[3], input_vars[4], input_vars[1], input_vars[2]]
