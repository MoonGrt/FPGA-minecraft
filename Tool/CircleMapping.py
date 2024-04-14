import math

# 定义 x 的取值范围
x_values = range(0, 160)
Radius = 225

# 计算每个 x 对应的 y
y_values = []
for x in x_values:
    y = math.sqrt(Radius**2 - x**2)
    y = round(y)
    y_values.append(y)

# 打印结果
for x, y in zip(x_values, y_values):
    print(f"x = {x}, y = {y}")

# # 打开 COE 文件并写入 COE 格式的数据
# with open("xy_map.coe", "w") as file:
#     # 写入 COE 文件头部信息
#     file.write("memory_initialization_radix=16;\n")
#     file.write("memory_initialization_vector=\n")

#     # 写入每个 y 数据
#     for idx, y in enumerate(y_values):
#         file.write(format(y, "02X"))  # 格式化为十六进制，并写入文件
#         if idx != len(y_values) - 1:
#             file.write(",\n")  # 每个数据后面加上逗号和换行符
#         else:
#             file.write(";\n")  # 最后一个数据用分号和换行符

# # 打开 MI 文件并写入 MI 格式的数据
# with open("xy_map.mi", "w") as file:
#     # 写入 COE 文件头部信息
#     file.write("#File_format=Hex\n")
#     file.write("#Address_depth=256\n")
#     file.write("#Data_width=8\n")

#     # 写入每个 y 数据
#     for idx, y in enumerate(y_values):
#         file.write(format(y, "02X"))  # 格式化为十六进制，并写入文件
#         file.write("\n")  # 每个数据后面加上换行符
