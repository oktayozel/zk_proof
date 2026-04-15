use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

// zero value = pedersen hash of 0
global ZERO_VALUE: Field = 0x2df8b940e5890e4e1377e05373fae69a1d754f6935e6a780b666947431f2cdcd;

fn main(
    // private inputs
    id: Field,
    r: Field,
    oldPath: [Field; 8],
    // public inputs
    oldRoot: pub Field,
    newRoot: pub Field,
    commitment: pub Field,
    index: pub Field
) {
    // check commitment = PedersenHash(id, r)
    let computed_commitment = pedersen_hash([id, r]);
    assert(commitment == computed_commitment);

    // verify old path is valid for empty leaf
    let computed_old_root = compute_merkle_root(ZERO_VALUE, index, oldPath);
    assert(oldRoot == computed_old_root);

    // verify new root is correct with commitment inserted
    let computed_new_root = compute_merkle_root(commitment, index, oldPath);
    assert(newRoot == computed_new_root);
}
