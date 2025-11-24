**# 🎨 Sui NFT Display Standard Challenge #2

A demonstration of Sui's Display Standard for NFTs, showcasing how metadata can be modified without changing the actual NFT data.

## 📋 Challenge Overview

This project implements an NFT using Sui's Display Standard, demonstrating the decoupling of hardcoded NFT metadata from flexible display metadata. The challenge culminates in "feeding the NFT to a rabbit" 🐰 which modifies the display metadata without touching the NFT itself.

## ✨ Features

- **NFT with Display Standard**: Complete implementation of Sui's Display Standard
- **Flexible Metadata**: Display templates can be modified independently from NFT data
- **Required Fields**: Implements `name`, `image_url`, and `description` in both NFT object and Display
- **Rabbit-Compatible**: Ready to be fed to the challenge's `feed_rabbit` function

## 🏗️ Project Structure

```
.
├── sources/
│   └── display_nft.move    # Main NFT module with Display Standard
├── Move.toml               # Package configuration
└── README.md              # This file
```

## 🚀 Quick Start

### Prerequisites

- Sui CLI installed and configured
- Active Sui wallet with testnet SUI tokens

### 1. Build the Project

```bash
sui move build
```

### 2. Deploy the Package

```bash
sui client publish --gas-budget 100000000
```

**Save these IDs from the output:**
- Package ID
- Display Object ID (type: `Display<MyNFT>`)
- Publisher ID

### 3. Mint Your NFT

```bash
sui client call \
  --package <YOUR_PACKAGE_ID> \
  --module display_nft \
  --function mint_nft \
  --args "My Cool NFT" "https://example.com/nft.png" "An amazing NFT for the challenge" \
  --gas-budget 10000000
```

### 4. Feed to Rabbit 🐰

```bash
sui client call \
  --package 0xaa3e79b37f336fa23ce354ddaa82391a7903690e78e46f61a197537be0b318b3 \
  --module display \
  --function feed_rabbit \
  --type-args <YOUR_PACKAGE_ID>::display_nft::MyNFT \
  --args <YOUR_DISPLAY_OBJECT_ID> \
  --gas-budget 10000000
```

## 📦 Deployed Example

Here's a working example deployment:

- **Package ID**: `0xf34d2ae5187bff8336a98cd62fd8a19a1cbb59217b319d1a53c5fbf472769192`
- **Display Object ID**: `0xe27c39b7f02ee88f4c1a570ac97b732890652e04b089d7407888595e87ff3a0f`
- **Sample NFT ID**: `0x8e1d760cc01a24ea82a5a6a1ef168743c682cf2adb566fb9f83af8474212887a`
- **NFT Metadata**:
    - Name: "WAT"
    - Image: WAT meme
    - Description: "Just WAT"

## 🔍 Key Concepts

### Display Standard

The Display Standard allows developers to create templates for how NFTs are displayed:

```rust
let keys = vector[
    string::utf8(b"name"),
    string::utf8(b"image_url"),
    string::utf8(b"description"),
];

let values = vector[
    string::utf8(b"{name}"),      // Template references NFT field
    string::utf8(b"{image_url}"), // Can be modified later
    string::utf8(b"{description}"),
];
```

### NFT Structure

```rust
public struct MyNFT has key, store {
    id: UID,
    name: String,        // Original data (immutable)
    image_url: String,   // Original data (immutable)
    description: String, // Original data (immutable)
}
```

### The Magic 🪄

- **NFT data** stays on-chain and unchanged
- **Display object** can be modified to change how the NFT appears
- **Rabbit function** modifies the Display, demonstrating flexibility

## 📚 Available Functions

### `mint_nft`
Mints a new NFT with custom metadata.

**Parameters:**
- `name`: The NFT name
- `image_url`: URL to the NFT image
- `description`: Description of the NFT

### `update_display`
Updates the Display object templates (optional).

**Parameters:**
- `display`: Mutable reference to Display object
- `name_template`: New template for name field
- `image_template`: New template for image_url field
- `description_template`: New template for description field

### Getter Functions
- `name(nft: &MyNFT)`: Returns NFT name
- `image_url(nft: &MyNFT)`: Returns NFT image URL
- `description(nft: &MyNFT)`: Returns NFT description

## 🎯 Challenge Completion Checklist

- [x] NFT has `name`, `image_url`, and `description` fields
- [x] Display object created with matching fields
- [x] Display object can be transferred and used
- [x] Compatible with `feed_rabbit` function signature
- [x] Successfully fed to rabbit 🐰

## 🐰 About feed_rabbit

The `feed_rabbit` function is provided by the challenge organizers:

```rust
public fun feed_rabbit<T: key>(display: &mut Display<T>)
```

This function takes your Display object and modifies it, demonstrating how display metadata can change without altering the underlying NFT data.

## 🔗 Useful Links

- [Sui Documentation](https://docs.sui.io/)
- [Display Standard Guide](https://docs.sui.io/standards/display)
- [Challenge Package](https://suiscan.xyz/testnet/object/0xaa3e79b37f336fa23ce354ddaa82391a7903690e78e46f61a197537be0b318b3)

## 💡 Tips

1. **Save your Display Object ID** - You'll need it for the feed_rabbit function
2. **Type arguments are required** - Don't forget `--type-args` when calling feed_rabbit
3. **Gas budget** - Make sure you have enough SUI for transactions
4. **Verify on explorer** - Check your transactions on Sui Explorer

## 🏆 Challenge Submission

**Deadline**: November 24th, 15:00 CET

Make sure to submit:
- Your package ID
- Display object ID
- Transaction hash of feeding to rabbit
- Any additional documentation

## 📝 License

This project is created for the Sui NFT Display Challenge.

## 🙏 Acknowledgments

Thanks to the Sui Foundation and challenge organizers for providing this learning opportunity!

---

**Happy Building on Sui!** 🚀✨**