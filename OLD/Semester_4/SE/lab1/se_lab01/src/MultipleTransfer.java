public class MultipleTransfer extends Transfer {

	private int numberOfTransfers;
	private Transfer[] transfers;

	public MultipleTransfer(int N) {
		super();
		numberOfTransfers = N;
		transfers = new Transfer[numberOfTransfers];

	}

	
	public MultipleTransfer(){
		super();
		numberOfTransfers = 0;
		transfers = new Transfer[numberOfTransfers];
	}



	public int getNumberOfTransfers() {
		return this.numberOfTransfers;
	}

	/**
	 * 
	 * @param numberOfTransfers
	 */
	public void setNumberOfTransfers(int numberOfTransfers) {
		this.numberOfTransfers = numberOfTransfers;
	}

	public void addTransfer(Transfer transfer){
		Transfer[] temp = new Transfer[this.numberOfTransfers];
		temp = transfers;
		transfers = new Transfer[++this.numberOfTransfers];
		for(int i = 0; i< temp.length; i++){
			transfers[i] = temp[i];
		}
		transfers[this.numberOfTransfers-1] = transfer;
	}


	/*public void setLastTransfer(Transfer temp){
		transfers[this.numberOfTransfers-1] = temp;
	}*/

	public Transfer[] getTransfers() {
		return transfers;
	}



	public void setTransfers(Transfer[] transfers) {
		this.transfers = transfers;
	}



}