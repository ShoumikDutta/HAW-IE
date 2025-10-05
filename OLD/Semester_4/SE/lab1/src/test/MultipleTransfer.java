

public class MultipleTransfer extends Transfer {

	private int numOfTransfer;
	private Transfer[] myTransfer;

	public MultipleTransfer(int numOfTransfer) {
		super();
		this.numOfTransfer = numOfTransfer;
		this.myTransfer = new Transfer[numOfTransfer];
		
	}
	
	
	
	
	
	public void addTransfer(Transfer myTransfer){
		int i=0;
		for (i=0; i<this.myTransfer.length; i++){
			if (this.myTransfer[i] == null){
				break;
			}
		}
		this.myTransfer[i] = myTransfer;
	}

}


