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
      if (n.equals("floor")) {
        if (fc.contains("stone") || fc.contains("ice") || fc.contains("leaves") || fc.contains("bridge") || fc.contains("trampoline"))
          return true;
      } else if (fc.contains(n)) {
        return true;
      }
    }
    return false;
  }

  boolean sTouching(FBox s, String n) {
    ArrayList<FContact> contactList = s.getContacts();
    for (FContact c : contactList) {
      if (n.equals("floor")) {
        if (c.contains("stone") || c.contains("wall") || c.contains("ice") || c.contains("leaves") || c.contains("bridge")) {
          return true;
        }
      } else if (c.contains(n)) {
        return true;
      }
    }
    return false;
  }
}
