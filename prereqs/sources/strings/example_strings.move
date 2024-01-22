module examples::strings {
    use std::string::String;
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;

    /// A dummy Object that holds a String type
    struct Name has key, store {
        id: UID,
        /// Here it is - the String type
        name: String
    }

    /// Create a name Object by passing raw bytes
    public fun mint_name(name: String, ctx: &mut TxContext): Name {
        Name { id: object::new(ctx), name }
    }
}
