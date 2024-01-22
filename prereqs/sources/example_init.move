module example::init_function {
    use sui::transfer;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};

    /// The one of a kind - created in the module initializer.
    struct CreatorCap has key {
        id: UID
    }

    /// This function is only called once on module publish.
    /// Use it to make sure something has happened only once, like
    /// here - only module author will own a version of a
    /// `CreatorCap` struct.
    fun init(ctx: &mut TxContext) {
        transfer::transfer(CreatorCap {
            id: object::new(ctx),
        }, tx_context::sender(ctx))
    }
}