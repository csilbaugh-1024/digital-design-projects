# AES-128 Hardware Encryption Core

## Project Goal
The goal of this project is to design an AES-128 encyrption core at the register-transfer level and then implement it in Vivado with VHDL. I will design the key schedule first, test it, and then I will design the rest of the encyrption core and test capabilities along the way as needed. Once the entire core is finished, I will use a testbench to verify correct encyrption consistent with the AES-128 model.

## How Does AES-128 work?
AES-128 is a powerful encryption algorithm first published in 1998 that is widely used today by many entities such as the U.S. Government. AES stands for "advanced encryption standard", and it encrypts 128 bits of information at a time. The pre-encyrpted information is called "plaintext". Additionally, the encrypted result that AES outputs, called "ciphertext", is determined by the encyrption key used. As for the key, it is a string of data that can be either 128, 192, or 256 bits long. These different key lengths are used by AES-128, AES-192, and AES-256, respectively, and greater key lengths result in a more complex, safer ciphertext. However, the plaintext and ciphertext are always 128 bits, no matter the size of the key.

AES-128 uses a series of operations in rounds to encrypt the plaintext. These operations are KeyExpansion, AddRoundKey, SubBytes, ShiftRows, and MixColumns. The number of rounds is based on the key, being either 10, 12, or 14 for AES-128, AES-192, and AES-256, respectively. AES encrypts by first applying AddRoundKey. Then, round 1 begins. In round 1, AES first applies SubBytes, then ShiftRows, then MixColumns, and then another instance of AddRoundKey. Next, AES simply repeats this process for the number of rounds specified by the key length. On the very last round, though, AES does not apply MixColumns. Instead, the final round only includes SubBytes, ShiftRows, and AddRoundKey because MixColumns in this round does not make the ciphertext any more or less secure. The result of the last round is the fully-encrypted ciphertext. 

Additionally, AES uses another operation called KeyExpansion, which is done by something called the key schedule. This operation uses the initial key to create 10, 12, or 14 more round keys that are used to encrypt the plaintext. In AES-128, for example, the key schedule supplies 11 different round keys, and each one is used in the operation AddRoundKey. For example, the first round key, the initial key, is used in AddRoundKey before round 1 begins. Then, the second key is used in round 2's instance of AddRoundKey, and so on until the 11th round key is used in round 10. When designing an AES encryption core, engineers can choose for the KeyExpansion process to be either fully completed before any encryption is done, or they can choose for it to expand the key as the rounds of the encyrption process progress. For this project, I will choose the former option.

## KeyExpansion
AES uses KeyExpansion to expand the starting key into 11, 13, or 15 total round keys depending on the starting key's length. These round keys are used by the AddRoundKey function as part of the encryption process. Since this project uses a 128-bit key consistent with AES-128, I will design KeyExpansion to expand the starting key into 10 more round keys, resulting in a total of 11 round keys for the 11 instances of AddRoundKey that occur in AES-128. Before expanding, AES operations are described with bytes. So, it is better to visualize the 128-bit key as a 16-byte key, instead. This way, the key can be represented as:

$$
K = K_1\ K_2\ K_3\ K_4\ K_5\ K_6\ K_7\ K_8\ K_9\ K_{10}\ K_{11}\ K_{12}\ K_{13}\ K_{14}\ K_{15}\ K_{16}
$$

Alternatively, the key could be represented as a 4x4 matrix called the "key array". This notation is useful because linear algebra is essential to AES, and this notation is especially useful for understanding the AddRoundKey operation in the encryption process.

$$
K =
\begin{bmatrix}
K_1 & K_5 & K_9 & K_{13} \\
K_2 & K_6 & K_{10} & K_{14} \\
K_3 & K_7 & K_{11} & K_{15} \\
K_4 & K_8 & K_{12} & K_{16} \\
\end{bmatrix}
$$

Next, the key is further rephrased into a set of four 32-bit words. Each word occupies its own column in the key array.

$$
K = W_1\ W_2\ W_3\ W_4
$$

$$
K =
\begin{bmatrix}
W_1 & W_2 & W_3 & W_4 \\
\end{bmatrix}
$$

After the initial key array is complete, KeyExpansion expands this matrix into a larger one called the "expanded key array", which has four rows and $N_b(N_r + 1)$ columns, where $N_b$ represents the number of bits in the plaintext divided by 32, and $N_r$ represents the number of rounds. Since this project uses AES-128, $N_b$ is equal to 128 divided by 32, which is 4, and there are 10 rounds. So, $N_b(N_r + 1)$ is equal to 4 times 11, which is 44. So, the expanded key array is a matrix that has four rows and 44 columns, resulting in a total 176 entries. Because the expanded key array houses all 11 round keys to be used in the encryption process, this configuration can alternatively be viewed as 11 separate key arrays whose columns are attached to each other, one array per instance of AddRoundKey. The first array is to be used for the first instance of AddRoundKey, the second for the second instance of AddRoundKey, and so on. 

$$
K =
\begin{bmatrix}
K_1 & K_5 & K_9 & K_{13} & K_{17} & ... & K_{173} \\
K_2 & K_6 & K_{10} & K_{14} & K_{18} & ... & K_{174} \\
K_3 & K_7 & K_{11} & K_{15} & K_{19} & ... & K_{175} \\
K_4 & K_8 & K_{12} & K_{16} & K_{20} & ... & K_{176} \\
\end{bmatrix}
$$

The leftmost 4 columns of the 44-column expanded key array contain the original, first key, and the next 10 round keys generated by KeyExpansion are all derived from this first key using a specific formula. However, it is more standard to represent the expanded key array as a 1x44 matrix whose elements are 32-bit words rather than single bytes, as this representation makes it easier to understand and follow the method KeyExpansion uses to generate the 10 new round keys.

$$
K =
\begin{bmatrix}
W_1 & W_2 & W_3 & W_4 & W_5 & ... & W_44 \\
\end{bmatrix}
$$



### AddRoundKey

### SubBytes

### ShiftRows

### MixColumns
