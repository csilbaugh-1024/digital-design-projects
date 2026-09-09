# AES-128 Encryption Core

## Project Goal
The goal of this project is to design an AES-128 encyrption core at the register-transfer level and then implement it in Vivado with VHDL. I will design the key schedule first, test it, and then I will design the rest of the encyrption core and test capabilities along the way as needed. Once the entire core is finished, I will use a testbench to verify correct encyrption consistent with the AES-128 model.

## How Does AES-128 work?
AES-128 is a powerful encryption algorithm first published in 1998 that is widely used today by many entities such as the U.S. Government. AES stands for "advanced encryption standard", and it encrypts 128 bits of information at a time. The pre-encyrpted information is called "plaintext". Additionally, the encrypted result that AES outputs, called "ciphertext", is determined by the encyrption key used. As for the key, it is a string of data that can be either 128, 192, or 256 bits long. These different key lengths are used by AES-128, AES-192, and AES-256, respectively, and greater key lengths result in a more complex, safer ciphertext. However, the plaintext and ciphertext are always 128 bits, no matter the size of the key.

AES-128 uses a series of operations in rounds to encrypt the plaintext. These operations are KeyExpansion, AddRoundKey, SubBytes, ShiftRows, and MixColumns. The number of rounds is based on the key, being either 10, 12, or 14 for AES-128, AES-192, and AES-256, respectively. AES encrypts by first applying AddRoundKey. Then, round 1 begins. In round 1, AES first applies SubBytes, then ShiftRows, then MixColumns, and then another instance of AddRoundKey. Next, AES simply repeats this process for the number of rounds specified by the key length. On the very last round, though, AES does not apply MixColumns. Instead, the final round only includes SubBytes, ShiftRows, and AddRoundKey because MixColumns in this round does not make the ciphertext any more or less secure. The result of the last round is the fully-encrypted ciphertext. 

Additionally, AES uses another operation called KeyExpansion, which is done by something called the key schedule. This operation uses the initial key to create 10, 12, or 14 more round keys that are used to encrypt the plaintext. In AES-128, for example, the key schedule supplies 11 different round keys, and each one is used in the operation AddRoundKey. For example, the first round key, the initial key, is used in AddRoundKey before round 1 begins. Then, the second key is used in round 2's instance of AddRoundKey, and so on until the 11th round key is used in round 10. When designing an AES encryption core, engineers can choose for the KeyExpansion process to be either fully completed before any encryption is done, or they can choose for it to expand the key as the rounds of the encyrption process progress. For this project, I will choose the former option.

## How Does Each Operation Work?

### KeyExpansion

### AddRoundKey

### SubBytes

### ShiftRows

### MixColumns
