use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

fn main(
    // private inputs
    r: Field,
    index: Field,
    hashpath: [Field; 8],
    // public inputs
    root: pub Field,
    id: pub Field
) {
    // compute commitment from id and r
    let commitment = pedersen_hash([id, r]);

    // verify commitment exists in tree at given index
    let computed_root = compute_merkle_root(commitment, index, hashpath);
    assert(root == computed_root);
}
