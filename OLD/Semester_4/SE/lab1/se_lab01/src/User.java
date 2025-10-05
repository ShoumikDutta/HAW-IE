public class User {

	private MultipleTransfer multTransfer;
	private TimeTransfer timeTransfer;
	private Transfer transfer;

	public User() {
		this.multTransfer = new MultipleTransfer();
		this.timeTransfer = new TimeTransfer();
		this.transfer = new Transfer();
	}

	public MultipleTransfer getMultTransfer() {
		return this.multTransfer;
	}

	/**
	 * 
	 * @param multTransfer
	 */
	public void setMultTransfer(MultipleTransfer multTransfer) {
		this.multTransfer = multTransfer;
	}

	public TimeTransfer getTimeTransfer() {
		return this.timeTransfer;
	}

	/**
	 * 
	 * @param timeTransfer
	 */
	public void setTimeTransfer(TimeTransfer timeTransfer) {
		this.timeTransfer = timeTransfer;
	}

	public Transfer getTransfer() {
		return this.transfer;
	}

	/**
	 * 
	 * @param transfer
	 */
	public void setTransfer(Transfer transfer) {
		this.transfer = transfer;
	}

}