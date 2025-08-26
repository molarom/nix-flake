{lib}: {
  /**
  Prefixes a string with a given number of spaces so that its total width matches `padding + length(str)`.

  Calculates the width as the length of `str` plus `padding` and then uses
  `lib.fixedWidthString` to left-pad the string with spaces until it reaches
  that width. This is useful for aligning or indenting strings in formatted
  output.

  **Type:**
  prefixSpace :: int -> string -> string

  **Parameters:**
  - `padding`: The number of spaces to add before the string.
  - `str`: The string to pad.

  **Returns:**
  - A new string left-padded with `padding` spaces.

  **Example:**
  ```nix
  prefixSpace 3 "foo"
  # => "   foo"
  */
  prefixSpace = padding: str: let
    strw = lib.stringLength str;
    width = padding + strw;
  in
    lib.fixedWidthString width " " str;
}
