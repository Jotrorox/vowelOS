<h1 align="center">Vowel OS</h1>

<p align="center">
  <img src="https://img.shields.io/github/languages/top/jotrorox/vowelOS?style=flat-square" alt="GitHub Top Language Badge">
  <img src="https://img.shields.io/github/languages/count/jotrorox/vowelOS?style=flat-square" alt="GitHub Language Count Badge">
  <img src="https://img.shields.io/github/repo-size/jotrorox/vowelOS?style=flat-square" alt="GitHub Repository Size Badge">
  <img src="https://img.shields.io/github/license/jotrorox/vowelOS?style=flat-square" alt="GitHub License Badge">
  <img src="https://img.shields.io/github/issues/jotrorox/vowelOS?style=flat-square" alt="GitHub Issues Badge">
  <img src="https://img.shields.io/github/stars/jotrorox/vowelOS?style=flat-square" alt="GitHub Stars Badge">
</p>

<hr>

<p align="center">
  <a href="#dart-about">About</a> &#xa0; | &#xa0; 
  <a href="#sparkles-features">Features</a> &#xa0; | &#xa0;
  <a href="#white_check_mark-development-requirements">Development Requirements</a> &#xa0; | &#xa0;
  <a href="#checkered_flag-starting-development-setup">Development Setup</a> &#xa0; | &#xa0;
  <a href="#dash-getting-started">Getting Started</a> &#xa0; | &#xa0;
  <a href="#raised_hands-contributing">Contributing</a> &#xa0; | &#xa0;
  <a href="#memo-license">License</a> &#xa0; | &#xa0;
  <a href="https://jotrorox.com" target="_blank">Author</a>
</p>

<br>

## :dart: About ##

Oh, It is that time of the week again ... I'm doing weird things based of the ideas by CodingSloth ([I can still recommend his Newsletter btw.](https://slothbytes.beehiiv.com/subscribe?ref=leLwLkdsZI)).
And yeah this time I think I really got bored, because guess what I wrote an entire operating system, only to do his coding exercise.
So this is this project just try and enjoy it and If you need nything just tell me.

## :sparkles: Features ##

:heavy_check_mark: Booting\
:heavy_multiplication_x: User Input\
:heavy_multiplication_x: Program Loop\
:heavy_check_mark: Vowel Counting\
:heavy_multiplication_x: Colorful Printing

**If you want more info or help just hit me up with the ways listed in the Starting section or on my website ([jotrorox.com](https://jotrorox.com/))**

## :white_check_mark: Development Requirements ##

Before starting :checkered_flag:, you need to have [Git](https://git-scm.com), [GCC Cross-Compiler](https://wiki.osdev.org/GCC_Cross-Compiler) and [nasm](https://nasm.us/) installed. (Atleast that should be it)

<br>

I also really can recomment you using [qemu](https://www.qemu.org/) to develop and run this.

## :checkered_flag: Starting (Development Setup) ##

```bash
# Clone this project
$ git clone https://github.com/Jotrorox/vowelOS

# Go into that directory
$ cd vowelOS

# Build the Project
$ ./build

# Run the Project
$ ./run
```

**If you encounter Problems just hit me up, I'm happy to help you get started**\
**You can do that over matrix: @jotrorox:matrix.org or Discord: https://discord.gg/RVr4cceFUt**

## :dash: Getting Started ##

So you really wanna use this for god knows what?\
Here you go I guess ...

#### Building an Iso #####

> Outdated

```bash
# Compile the code
$ nasm -f bin boot.asm -o boot.bin

# Creating a floppy disk that holds all the data
$ dd if=/dev/zero of=floppy.img bs=1024 count=1440
$ dd if=boot.bin of=floppy.img conv=notrunc

# Building the Iso
$ mkisofs -o boot.iso -b floppy.img .
```

Then just run it of a usb or in virtualbox

## :raised_hands: Contributing ##

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## :memo: License ##

This project is under the AGPLv3 License. For more details, see the [LICENSE](LICENSE) file.

<br>

Made with :heart: by <a href="https://jotrorox.com" target="_blank">Jotrorox</a>

&#xa0;

<a href="#top">Back to top</a>