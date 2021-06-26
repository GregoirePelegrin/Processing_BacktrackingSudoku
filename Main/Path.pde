class Path{
    ArrayList<Cell> path;
    int size;

    Path(int _size){
        this.size = _size;
        this.path = new ArrayList<Cell>();

        cells.get(0).populate();
        cells.get(0).nextStep();
        this.path.add(cells.get(0));
    }

    void display(){
        stroke(255);

        for(int i=1; i<this.size; i++){
            if(i % (int)Math.sqrt(this.size) == 0) strokeWeight(5);
            else strokeWeight(1);
            line(i*width/this.size, 0, i*width/this.size, height);
            line(0, i*height/this.size, width, i*height/this.size);
        }
        float textSpreadingHeight = height/this.size;
        float textSpreadingWidth = width/this.size;
        float textOffsetHeight = 0.5*textSpreadingHeight;
        float textOffsetWidth = 0.5*textSpreadingWidth;
        for(Cell cell : cells){
            String content;
            if(cell.realValue != null){
                fill(189, 195, 199);
                content = String.valueOf(cell.realValue);
            } else if(!cell.testValue.equals(Integer.valueOf(0))){
                fill(217, 203, 158);
                content = String.valueOf(cell.testValue);
            } else {
                fill(42, 44, 43);
                content = "x";
            }
            text(content, 
                textOffsetWidth + cell.column*textSpreadingWidth,
                textOffsetHeight + cell.row*textSpreadingHeight);
        }
    }
    void pop(){
        this.path.remove(this.path.size()-1).reinitialize();
        if(!this.path.get(this.path.size()-1).nextStep()) this.pop();
    }
    boolean update(){
        Cell cell = path.get(path.size()-1);
        if(cell.column == SIZE_GRID-1 && cell.row == SIZE_GRID-1) {
            if(!cell.nextStep()) return false;
        } else {
            Cell nextCell = cells.get(cell.row*SIZE_GRID + cell.column + 1);
            if(!nextCell.populate()){
                if(!cell.nextStep()) return false;
                return true;
            }
            nextCell.nextStep();
            this.path.add(nextCell);
        }
        return true;
    }
}