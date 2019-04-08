package JZW;


public class Page {
	private int recordCount;	//记录总数
	private int pageSize;	//每页记录数
	private int start;		//显示开始页
	private int end;			//显示结束页
	private int pageCount;	//计算总页数
	private int currPage;	//当前页面的页码
	
	public Page() {
		
	}
	
	public Page(int recordCount,int pageSize,int start,int end,int pageCount,int currPage) {
		this.recordCount=recordCount;
		this.pageSize=pageSize;
		this.start=start;
		this.end=end;
		this.pageCount=pageCount;
		this.currPage=currPage;
	}
	
	public int getRecordCount() {
    	return recordCount;
    }
    
    public void setRecordCount(int recordCount) {
    	this.recordCount = recordCount;
    }
    
    public int getPageSize() {
    	return pageSize;
    }
    
    public void setPageSize(int pageSize) {
    	this.pageSize = pageSize;
    }
    
    public int getStart() {
    	return start;
    }
    
    public void setStart(int start) {
    	this.start = start;
    }
    
    public int getEnd() {
    	return end;
    }
    
    public void setEnd(int end) {
    	this.end = end;
    }
    
    public int getPageCount() {
    	return pageCount;
    }
    
    public void setPageCount(int pageCount) {
    	this.pageCount = pageCount;
    }
    
    public int getCurrPage() {
    	return currPage;
    }
    
    public void setCurrPage(int currPage) {
    	this.currPage = currPage;
    }
    
    
    
    
	
}
