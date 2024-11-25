class FGameObject extends FBox {
  FGameObject(float width, float height) {
        super(width, height);
    }


  void act() {
  }


  boolean isTouching(String n) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(n)) {
        return true;
      }
    }
    return false;
  }
}
