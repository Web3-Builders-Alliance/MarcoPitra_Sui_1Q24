module examples::string_operations {
    use std::string::{Self, String};
    use std::option::Option;

    /// Constants can't be Strings; and they're not public.
    const HELLO_WORLD: vector<u8> = b"Hello, World!";

    /// But a function can pack a string and make it accessible.
    /// Note: `string::utf8` fails if the string is not valid UTF-8.
    public fun hello_world(): String {
        string::utf8(HELLO_WORLD)
    }

    /// Checks if it's a valid UTF-8 String and returns an option
    public fun new_string_safe(bytes: vector<u8>): Option<String> {
        string::try_utf8(bytes)
    }
}
