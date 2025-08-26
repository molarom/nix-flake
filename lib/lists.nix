{lib}: {
  /**
  Formats a list of strings into a single string with optional padding.

  Given a non-empty list of strings, this function returns a single string
  where:
  - The first element is kept as-is.
  - All subsequent elements are prefixed with `padding` using `prefixSpace`.
  - All elements are then joined together using the specified `sep`.

  This is useful when you need to produce aligned, padded, or indented
  multi-line strings, or generate a command-line argument list with consistent
  formatting.

  **Parameters**:
  - `list`: A non-empty list of strings to format.
  - `sep`: A string separator used to join the formatted list elements.
  - `padding`: A string to prefix (pad) all elements after the first.

  **Returns**:
  - A single string consisting of the formatted list elements joined by `sep`.

  **Example**:
  ```nix
  formatStringList [ "foo" "bar" "baz" ] " " "--"
  # => "foo --bar --baz"
  */
  formatStringList = list: sep: padding: let
    lHead = builtins.elemAt list 0;
    lTail = builtins.tail list;
    paddedTail = builtins.map (x: lib.romalor.prefixSpace padding x) lTail;
    paddedList = [lHead] ++ paddedTail;
  in
    lib.concatStringsSep sep paddedList;
}
