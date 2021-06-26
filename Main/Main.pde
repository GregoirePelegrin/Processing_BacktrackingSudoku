int SIZE_GRID;

ArrayList<Cell> cells;
Path path;

void setup(){
    size(600, 600);
    frameRate(60);
    textSize(20);
    textAlign(CENTER, CENTER);
    background(47, 79, 79);

    Table sudoku = loadTable("Sudoku.csv");
    SIZE_GRID = sudoku.getRowCount();

    cells = new ArrayList<Cell>();

    int tempSize = (int) Math.sqrt(SIZE_GRID);
    for(int row=0; row<SIZE_GRID; row++){
        for(int column=0; column<SIZE_GRID; column++){
            int mat = (int)((float)row/tempSize)*tempSize + (int)((float)column/tempSize);
            if(sudoku.getInt(row, column) == 0) cells.add(new Cell(column, mat, row));
            else cells.add(new Cell(column, mat, row, sudoku.getInt(row, column)));
        }
    }
    
    path = new Path(SIZE_GRID);
    path.display();
}

void draw(){
    background(47, 79, 79);


    if(!path.update()){
        boolean mustDoAgain = false;
        for(Cell cell : cells){
            if(cell.realValue == null && cell.testValue.equals(Integer.valueOf(0))){
                mustDoAgain = true;
                path.pop();
                break;
            }
        }
        if(!mustDoAgain){
            println("Solved it!");
            path.display();
            noLoop();
        }
    }

    path.display();
}