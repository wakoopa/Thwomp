# Thwomp
SWF renderer for Ruby

Note: work in progress!

## Installiing Thwomp

Requirements:
* sdl
* boost
* antigrain (libagg)
* gnash

### OSX

**Make sure homebrew is installed:**

```
  /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
```

**Update your homebrew:**

```
  brew update
```

**Install SDL dev. package:**

Be warned, if you are running OSX Lion you'll need to set the default compiler to GCC instead of the GCC LVM compiler.
```
  export CC=gcc-4.2
```

After that:

```
  cd /tmp/
  wget http://www.libsdl.org/release/SDL-1.2.14.tar.gz
  tar -xzf SDL-1.2.14.tar.gz
  cd SDL-1.2.14
  ./configure
  make
  make install
```

**Install boost:**

```
  brew install boost
```

**Install anti grain:**

```
  brew install libagg
```

**Install gnash:**

Now this is a tricky one. There is a bug in the configure script of gnash, that won't detect the correct version of ffmpeg. It could be possible that the configure script will crash. The default installation of gnash will fallback to gstreamer.

Anway... this will install gnash-dump which will allow us to dump RAW files from an input SWF file:

Option 1: Install from source

```
  cd /tmp/
  git clone git://git.sv.gnu.org/gnash.git
  cd gnash
  ./autogen
  ./configure --prefix=/usr/local/gnash-dump --enable-renderer=agg --enable-gui=dump --enable-media=no --disable-kparts --disable-nsapi --disable-menus  make
  make
  sudo make install
```

Option 2: Install from tarball from the intertubes:

```
  cd /tmp/
  wget ftp://ftp.mirror.nl/pub/mirror/gnu/gnash/0.8.9/gnash-0.8.9.tar.gz
  tar -xzf gnash-0.8.9.tar.gz
  cd gnash-0.8.9
  ./configure --prefix=/usr/local/gnash-dump --enable-renderer=agg --enable-gui=dump --enable-media=no --disable-kparts --disable-nsapi --disable-menus
  make
  sudo make install
```

Don't forget to add sudo before gnash.

### Ubuntu

```
  git clone git://git.sv.gnu.org/gnash.git
  cd gnash
  sudo apt-get install -y libagg-dev automake autoconf libtool libltdl-dev libjpeg-dev libgif-dev libboost-dev libboost-thread-dev libboost-program-options-dev libfontconfig1-dev libfreetype6-dev ffmpeg libpng-dev libspeex-dev libsdl-dev libspeexdsp-dev imagemagick
  ./autogen.sh
  ./configure --prefix=/usr/local/gnash-dump --enable-renderer=agg --enable-gui=dump --enable-media=no --disable-menus
  make
  sudo make install
```

## Installing the thwomp gem

```
  gem install thwomp
```

## Usage

**Finding the most suitable thumbnail for a swf movie:**

```Ruby
  thumbnail_path = Thwomp.pick("http://www.example.com/flash.swf")
```

This picks the right renderer based on file extension. If that doesn't work
for you, you can instantiate the right renderer yourself. Like this;

```Ruby
  renderer = Thwomp::Renderers::SWF.new("http://www.example.com/flash.swf")
  thumbnail_path = ThumbnailPicker.pick(renderer.frames)
```

**Creating a GIF animation from a swf movie:**

```Ruby
  renderer = Thwomp::Renderer.new("http://www.example.com/flash.swf")
  data = Thwomp::AnimationPreview.new(renderer).gif_data
```
