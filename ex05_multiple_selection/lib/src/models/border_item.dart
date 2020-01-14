class BorderItem {
  BorderItem(
    this.index,
    this.opacityForward,
    this.opacity,
  );

  int index;
  double opacity;
  bool opacityForward;

  @override
  String toString() {
    return "$index, $opacity";
  }
}
