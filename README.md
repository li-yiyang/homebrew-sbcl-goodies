# Ryo's SBCL-Goodies (macOS Only)

## About
This tap includes my port of [SBCL-Goodies](https://github.com/sionescu/sbcl-goodies/) to macOS arm64 platform.

For linux platform, please refer to [SBCL-Goodies](https://github.com/sionescu/sbcl-goodies/) project, which provides a tar release.

## How do I install these formulae?
```shell
brew install li-yiyang/sbcl-goodies/sbcl-goodies
```

Or `brew tap li-yiyang/sbcl-goodies` and then `brew install sbcl-goodies`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "li-yiyang/sbcl-goodies"
brew "sbcl-goodies"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

### SBCL features
+ `:sb-core-compression` (use zstd lib to compress the saved executable)
+ `:sb-linkable-runtime` (not functional on macOS now)
+ `:mark-region-gc` (parallel GC)
+ `:sb-fasteval`
+ `:sb-ldb`
+ `:sb-thread`
+ `:sb-xref-for-internals`
+ `:sb-after-xc-core`

### Statically linked goodies (libraries)
+ libzstd

  <details><summary>BSD License</summary>
  ```
  BSD License

  For Zstandard software

  Copyright (c) Meta Platforms, Inc. and affiliates. All rights reserved.

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright notice, this
     list of conditions and the following disclaimer.

   * Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation
     and/or other materials provided with the distribution.

   * Neither the name Facebook, nor Meta, nor the names of its contributors may
     be used to endorse or promote products derived from this software without
     specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  ```
  </details>

## License
SBCL-Goodies use MIT License.
For detailed licenses of each linked library, see above.

```
Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
```