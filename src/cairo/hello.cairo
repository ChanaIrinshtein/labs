use debug::PrintTrait;
use traits::OptionTrait;
use option::OptionTrait;

fn main(x: felt252, y:felt252) {
    assert(x != y, 'error, x is equal to y');
}


// test
fn test_main() {
    main(1,2)
}
// ______________________________________

fn main2(){
    let immutable_var: felt252 = 17;
    let mut mutable_var: felt252 = immutable_var;
    mutable_var = 38;

    assert(mutable_var != immutable_var, 'mutable equals immutable');
}

fn test_main2() {
    main2();
}

// ______________________________________

fn main3() {
    let x = 3;
}

fn inc(x:u32) -> u32 {
    x + 1;
}

// ______________________________________

fn foo(x: u8, y:u8) {

}

fn main4() {
    let x = 3;
    let y = 4;

    foo(:x, :y);
}

fn main5() {
    let is_awesome = true;
    let verision = u8 = 2;

    if is_awesome && version >0 {
        'Lets code!'.print();
    } else {
        'Great things are coming'.print();
    }
    
}

// ______________________________________

fn main6() {
    let x = 'Cairo is awesome';
    x.print();
    let c = 'A';
    c.print();
}
elt252
// ______________________________________

fn main7() {
    let x: 3618502788666131213697322783095070105623107215331596699973092056135872020480;
    let y: 1;
    assert(x + y == 0, 'P == 0 (mod P)');
}

// ______________________________________

fn main8() {
    // let cairo_prime: felt252 = 3618502788666131213697322783095070105623107215331596699973092056135872020481;
    let x = 3618502788666131213697322783095070105623107215331596699973092056135872020480;
    assert(x + 1 == 0, '(P -1) + 1 ==0 (mod P)');
    assert(x == 0 - 1, 'subtraction is modular');
    assert(x * x == 1, 'multiplication is modular');
}

// ______________________________________

fn main9() {
    let two = TryInto::try_into(2).unwarp();

    assert(felt252_div(2, two) == 1, '2 ==1 * 2');

    let half_prime_plus_one = 1809251394333065606848661391547535052811553607665798349986546028067936010241;
    assert(felt252_div(1, two) == half_prime_plus_one, '1 == ((P + 1) / 2) * 2 (mod P)');
}
