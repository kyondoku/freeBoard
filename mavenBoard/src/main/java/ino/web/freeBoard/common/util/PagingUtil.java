package ino.web.freeBoard.common.util;

public class PagingUtil {

	public static final int PAGE_SIZE = 10;
	public static final int BLOCK_SIZE = 10;
	
	private int listCnt;

	private int curPage;
	private int totPage;
	private int pageBegin;
	private int pageEnd;
	
	private int curBlock;
	private int totBlock;
	private int blockBegin;
	private int blockEnd;
	
	private int prevPage;
	private int nextPage;
	
	public PagingUtil(int curPage, int listCnt) {
		this.curPage = curPage;
		curBlock = 1;
		
		setListCnt(listCnt); //총 게시글 수
		System.out.println("listCnt : " + getListCnt());	
		
		setTotPage(listCnt); //총 페이지 수
		System.out.println("totPage : " + getTotPage());
		
		setPageRange();

		setTotBlock(totPage);
		System.out.println("totBlock : " + getTotBlock());
		
		setBlockRange();
	}
	
	public void setPageRange() {
		pageBegin = (curPage-1) * PAGE_SIZE + 1;
		System.out.println("pageBegin : " + pageBegin);
		pageEnd = pageBegin + PAGE_SIZE - 1;
		System.out.println("pageEnd : " + pageEnd);
	}
	
	public void setBlockRange() {
		curBlock = (int)Math.ceil((curPage-1) / BLOCK_SIZE) + 1;
		System.out.println("curBlock : " + curBlock);
		blockBegin = (curBlock - 1) * BLOCK_SIZE + 1;
		blockEnd = blockBegin + BLOCK_SIZE - 1;
		if(blockEnd > totPage){
			blockEnd = totPage;
		}
		//이전, 다음 블록!
		prevPage = (curPage == 1) ? 1 : (curPage - 1);
		nextPage = (curPage == totPage) ? totPage : (curPage + 1);
		
	}

	public int getPrevPage() {
		return prevPage;
	}
	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}
	public int getNextPage() {
		return nextPage;
	}
	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
	public int getListCnt() {
		return listCnt;
	}
	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}
	public int getTotPage() {
		return totPage;
	}
	
	public void setTotPage(int listCnt) {
		totPage = (int) Math.ceil(listCnt * 1.0 / PAGE_SIZE);
		// listCnt(총 게시글수)가 11일 경우 listCnt
	}
	
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPageBegin() {
		return pageBegin;
	}
	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}
	public int getPageEnd() {
		return pageEnd;
	}
	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}
	public int getCurBlock() {
		return curBlock;
	}
	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}
	public int getTotBlock() {
		return totBlock;
	}
	
	public void setTotBlock(int totPage) {
		totBlock = ((int) Math.ceil(totPage / BLOCK_SIZE) == 0) ? 1 : (int) Math.ceil(totPage / BLOCK_SIZE);
	}
	
	public int getBlockBegin() {
		return blockBegin;
	}
	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}
	public int getBlockEnd() {
		return blockEnd;
	}
	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}
	
}
