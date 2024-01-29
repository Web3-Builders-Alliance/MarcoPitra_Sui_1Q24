import { getFullnodeUrl, SuiClient } from "@mysten/sui.js/client";
import { Ed25519Keypair } from "@mysten/sui.js/keypairs/ed25519";
import { bcs } from "@mysten/sui.js/bcs";
import { TransactionBlock } from "@mysten/sui.js/transactions";
import wallet from "./dev-wallet.json";

const enrollment_object_id = "0x326054a2db6192fcd3085cfde6e92d1a917f3df953f5327f7d4e3c1457e8816e";
const cohort = "";

// We're going to import our keypair from the wallet file
const keypair = Ed25519Keypair.fromSecretKey(new Uint8Array(wallet));

// Create a devnet client
const client = new SuiClient({ url: getFullnodeUrl("devnet") });

(async () => {
  try {
    const txb = new TransactionBlock();

    // Github account
    const github = new Uint8Array(Buffer.from("git-marcopitra"));
    let serialized_github = txb.pure(bcs.vector(bcs.u8()).serialize(github));

    let enroll = txb.moveCall({
      target: `${enrollment_object_id}::enrollment::enroll`,
      arguments: [txb.object(cohort), serialized_github],
    });

    let txid = await client.signAndExecuteTransactionBlock({
      signer: keypair,
      transactionBlock: txb,
    });
    console.log(`Success! Check our your TX here: \nhttps://suiexplorer.com/txblock/${txid.digest}?network=devnet`);
  } catch (e) {
    console.error(`Oops, something went wrong: ${e}`);
  }
})();
