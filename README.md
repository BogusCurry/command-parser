# Command Parser SubModule

This module is a helper tool to parse commands entered by the players.


## Installation

This script is not standalone and must be used with your own script, as it doesn't have a `definition.xml` file.


### Direct installation (not recommended)

You only need to copy the file `parse-args.lua` to your script's directory. Whenever the file needs updating, this manual step must be done. This is a non-desirable method as, if commited, it will create duplicate versions of this file across different repositories.


### Using as a Git Sub-Module (recommended)

At the script base folder, execute the two commands

```
$ git submodule add https://github.com/RisingWorld/command-parser
$ git commit -am 'Added command parser sub-module'
```

This will create a directory called `command-parser`, and clone this repository in it. However, the content of the directory will not be commited with the rest of your project, only the directory entry and a file called `.gitmodules` 

Whenever the project needs updating, perform this command, also at the script's base folder :

```
$ git submodule update --remote command-parser
```

Refer to the [official Git documentation](http://www.git-scm.com/book/en/v2/Git-Tools-Submodules) for more information.


## Usage

```
include('command-parser/parse-args.lua');

function onPlayerCommand(event)
  -- ex: /cmd -a arg -b="foo bar" "long argument" -x=dave
  local args, flags = parseArgs(event.command);

  print("args:");
  for i=1,#args do
    print(i..":"..args[i]);
  end;

  print("flags:");
  for k,v in pairs(flags) do
    print(k..(v=="" and "" or "="..v));
  end;
end
addEvent("PlayerCommand", onPlayerCommand);
```

### Output
```
args:
1: /cmd
2: arg
3: long argument
flags:
a
b=foo bar
x=dave
```


## API Reference

* `parseArgs(...)` a variadic function receiving strings (which will be concatenated with a space--`" "`--character) that will be parsed into two categories; `arguments` and `flags`. (See usage example.) Returns `args` and `flags`.


## License

Copyright (c) 2015 Yanick Rochon

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.