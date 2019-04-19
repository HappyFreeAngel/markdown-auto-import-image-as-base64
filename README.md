# markdown-auto-import-image-as-base64
markdown-auto-import-image-as-base64

Typora 文档的图片自动导入markdown.md 文档中，方便SCM管理.

````
happy:base64image happy$ tree
.
├── base64img.sh
└── examples
    ├── 2.md
    ├── base64img.sh -> ../base64img.sh
    ├── image
    │   ├── 1555555321007.png
    │   ├── 1555569777033.png
    │   ├── 1555569794735.png
    │   └── 1555570835403.png
    ├── origin.md
    └── test.sh
    
    
happy:examples happy$ more test.sh
#!/bin/bash
cp origin.md  2.md ;./base64img.sh -f 2.md -i image -s 100


happy:examples happy$ ./test.sh
参数说明: -i 图片路径 -s 空行数量
this is -f the arg is ! 2.md
this is -i the arg is ! image
this is -s the arg is ! 100
文件名=/Users/happy/work/supper-tool/supper-tool/app/base64image/examples/2.md image_path=image space_line_count=100
````
