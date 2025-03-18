public with sharing class Student {
    public Student() {

    }
    public enum Category {PRIMARY,SECONDARY,SENIOR_SECONDARY}
    integer id;
    string name;
    Category studentCategory;

    public Student(integer id,string name, Category studentCategory)
    {
       this.id = id;
       this.name = name;
       this.studentCategory = studentCategory;
    }

    public Category getCategory()
    {
        return studentCategory; // PRIMARY
    }

    public string getCategoryAsString()
    {
        return studentCategory.name();
    }

    public integer getId()
    {
        return id; // 1
    }
    public String sName()
    {
        return name;
    }


}