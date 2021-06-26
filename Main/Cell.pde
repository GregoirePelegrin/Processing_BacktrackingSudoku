class Cell{
    int column;
    int matrix;
    int row;

    ArrayList<Integer> toTest;
    Integer realValue;
    Integer testValue;

    Cell(int _column, int _matrix, int _row){
        this.column = _column;
        this.matrix = _matrix;
        this.row = _row;

        this.toTest = new ArrayList<Integer>();
        this.realValue = null;
        this.testValue = new Integer(0);
    }
    Cell(int _column, int _matrix, int _row, int _value){
        this.column = _column;
        this.matrix = _matrix;
        this.row = _row;

        this.toTest = new ArrayList<Integer>();
        this.realValue = Integer.valueOf(_value);
        this.testValue = new Integer(0);
    }

    void display(){
        String result = "Cell(real=" + this.realValue + ", test=" + this.testValue + ", toTest=[";
        for(Integer value : this.toTest) result += value + ",";
        println(result + "])");
    }
    boolean nextStep(){
        if(this.toTest.size() == 0) return false;
        this.testValue = this.toTest.remove(0);
        return true;
    }
    boolean populate(){
        if(this.realValue != null){
            this.toTest.add(this.realValue);
            return true;
        }
        for(int i=1; i<=SIZE_GRID; i++) this.toTest.add(Integer.valueOf(i));
        for(Cell cell : cells) if(cell.column == this.column || cell.row == this.row || cell.matrix == this.matrix){
            this.toTest.remove(cell.realValue);
            this.toTest.remove(cell.testValue);
        }
        return (this.toTest.size() == 0) ? false : true;
    }
    void reinitialize(){
        if(this.realValue == null){
            this.toTest = new ArrayList<Integer>();
            this.testValue = Integer.valueOf(0);
        }
    }
}