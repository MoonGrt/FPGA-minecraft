<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
	<a href="https://github.com/MoonGrt/FPGA-Minecraft">
	<img src="images/logo.png" alt="Logo" width="80" height="80">
	</a>
<h3 align="center">FPGA-Minecraft</h3>
	<p align="center">
	This FPGA project involves the development of a Minecraft game entirely in hardware. The game enables players to place and break blocks, move, and fly. It utilizes a rendering pipeline to calculate the color of each pixel, ultimately displaying the generated frames on an HDMI screen. This hardware-based approach ensures efficient real-time rendering and interaction within the game environment. 
	<br />
	<a href="https://github.com/MoonGrt/FPGA-Minecraft"><strong>Explore the docs »</strong></a>
	<br />
	<br />
	<a href="https://github.com/MoonGrt/FPGA-Minecraft">View Demo</a>
	·
	<a href="https://github.com/MoonGrt/FPGA-Minecraft/issues">Report Bug</a>
	·
	<a href="https://github.com/MoonGrt/FPGA-Minecraft/issues">Request Feature</a>
	</p>
</div>


<!-- CONTENTS -->
<details open>
  <summary>Contents</summary>
  <ol>
    <li><a href="#file-tree">File Tree</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

└─ Project
  ├─ LICENSE
  ├─ README.md
  ├─ /HDMI/
  │ └─ /src/
  │   ├─ dk_video.cst
  │   ├─ dk_video.sdc
  │   ├─ testpattern.v
  │   ├─ video_top.v
  │   ├─ /dvi_tx/
  │   │ ├─ dvi_tx.ipc
  │   │ ├─ dvi_tx.v
  │   │ └─ dvi_tx.vo
  │   └─ /gowin_rpll/
  │     ├─ TMDS_rPLL.ipc
  │     ├─ TMDS_rPLL.mod
  │     └─ TMDS_rPLL.v
  ├─ /images/
  ├─ /Matlab/
  │ ├─ sight_line.m
  │ ├─ sight_line.mlapp
  │ ├─ test1.m
  │ └─ test2.m
  ├─ /minecraft_moon/
  │ └─ /minecraft_moon.srcs/
  │   ├─ /sim_1/
  │   │ └─ /new/
  │   │   └─ test.v
  │   └─ /sources_1/
  │     ├─ angle_relative.v
  │     ├─ angle_to_coord.v
  │     ├─ constants.vh
  │     ├─ disp_buf.v
  │     ├─ freq_div.v
  │     ├─ inventory_register.v
  │     ├─ player_station.v
  │     ├─ pll_entr_tb.v
  │     ├─ ppl_entry.v
  │     ├─ ppl_proc.v
  │     ├─ top.v
  │     ├─ viewport_params.v
  │     └─ viewport_scanner.v
  ├─ /test/
  └─ /Tool/
    ├─ 0.png
    ├─ 18.png
    ├─ c.v
    ├─ CircleMapping.py
    ├─ png_to_mi.py
    ├─ textures.mi
    ├─ xy_map.coe
    └─ xy_map.mi
<!-- CONTRIBUTING -->
## Contributing
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.
If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!
1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
<p align="right">(<a href="#top">top</a>)</p>


<!-- LICENSE -->
## License
Distributed under the MIT License. See `LICENSE` for more information.
<p align="right">(<a href="#top">top</a>)</p>


<!-- CONTACT -->
## Contact
MoonGrt - 1561145394@qq.com
Project Link: [MoonGrt/](https://github.com/MoonGrt/)
<p align="right">(<a href="#top">top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## Acknowledgments
* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
* [Malven's Grid Cheatsheet](https://grid.malven.co/)
* [Img Shields](https://shields.io)
* [GitHub Pages](https://pages.github.com)
* [Font Awesome](https://fontawesome.com)
* [React Icons](https://react-icons.github.io/react-icons/search)   
<p align="right">(<a href="#top">top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/MoonGrt/FPGA-Minecraft.svg?style=for-the-badge
[contributors-url]: https://github.com/MoonGrt/FPGA-Minecraft/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/MoonGrt/FPGA-Minecraft.svg?style=for-the-badge
[forks-url]: https://github.com/MoonGrt/FPGA-Minecraft/network/members
[stars-shield]: https://img.shields.io/github/stars/MoonGrt/FPGA-Minecraft.svg?style=for-the-badge
[stars-url]: https://github.com/MoonGrt/FPGA-Minecraft/stargazers
[issues-shield]: https://img.shields.io/github/issues/MoonGrt/FPGA-Minecraft.svg?style=for-the-badge
[issues-url]: https://github.com/MoonGrt/FPGA-Minecraft/issues
[license-shield]: https://img.shields.io/github/license/MoonGrt/FPGA-Minecraft.svg?style=for-the-badge
[license-url]: https://github.com/MoonGrt/FPGA-Minecraft/blob/master/LICENSE

