enum TetrominoType {
  i,
  o,
  t,
  s,
  z,
  j,
  l,
  dot,
  domino,
  l3,
  square3,
  cross,
  bigL,
}

extension TetrominoTypeX on TetrominoType {
  bool get isRare => switch (this) {
        TetrominoType.cross ||
        TetrominoType.bigL ||
        TetrominoType.square3 =>
          true,
        _ => false,
      };

  int get difficultyWeight => switch (this) {
        TetrominoType.dot => 1,
        TetrominoType.domino => 2,
        TetrominoType.o => 3,
        TetrominoType.i => 4,
        TetrominoType.l3 => 5,
        TetrominoType.s || TetrominoType.z => 6,
        TetrominoType.t || TetrominoType.j || TetrominoType.l => 7,
        TetrominoType.square3 => 8,
        TetrominoType.cross => 9,
        TetrominoType.bigL => 10,
      };
}
