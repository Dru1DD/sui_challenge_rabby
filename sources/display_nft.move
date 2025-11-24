module sui_challenge_rabby::display_nft {

    use std::string::{Self, String};
    use sui::display::{Self, Display};
    use sui::object::{Self, UID};
    use sui::package;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct DISPLAY_NFT has drop {}

    public struct MyNFT has key, store {
        id: UID,
        name: String,
        image_url: String,
        description: String,
    }

    fun init(_witness: DISPLAY_NFT, ctx: &mut TxContext) {
        let keys = vector[
            string::utf8(b"name"),
            string::utf8(b"image_url"),
            string::utf8(b"description"),
        ];

        let values = vector[
            string::utf8(b"{name}"),
            string::utf8(b"{image_url}"),
            string::utf8(b"{description}"),
        ];

        let publisher = package::claim(_witness, ctx);

        let mut display = display::new_with_fields<MyNFT>(
            &publisher,
            keys,
            values,
            ctx,
        );

        display::update_version(&mut display);

        transfer::public_transfer(publisher, tx_context::sender(ctx));
        transfer::public_transfer(display, tx_context::sender(ctx));
    }


    public entry fun mint_nft(
        name: vector<u8>,
        image_url: vector<u8>,
        description: vector<u8>,
        ctx: &mut TxContext,
    ) {
        let nft = MyNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            image_url: string::utf8(image_url),
            description: string::utf8(description),
        };

        transfer::public_transfer(nft, tx_context::sender(ctx));
    }

    public entry fun update_display(
        display: &mut Display<MyNFT>,
        name_template: vector<u8>,
        image_template: vector<u8>,
        description_template: vector<u8>,
    ) {
        display::edit(display, string::utf8(b"name"), string::utf8(name_template));
        display::edit(display, string::utf8(b"image_url"), string::utf8(image_template));
        display::edit(display, string::utf8(b"description"), string::utf8(description_template));
        display::update_version(display);
    }

    public fun name(nft: &MyNFT): String {
        nft.name
    }

    public fun image_url(nft: &MyNFT): String {
        nft.image_url
    }

    public fun description(nft: &MyNFT): String {
        nft.description
    }
}
