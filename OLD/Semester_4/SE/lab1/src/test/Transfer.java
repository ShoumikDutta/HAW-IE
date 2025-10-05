package test;

public class Transfer {

	protected String transferId;
	protected String nameOfPayee;
	protected int account;
	protected int bankid;
	protected float amount;
	protected String reference;

	public String getTransferId() {
		return this.transferId;
	}

	public void setTransferId(String transferId) {
		this.transferId = transferId;
	}

	public String getNameOfPayee() {
		return this.nameOfPayee;
	}

	public void setNameOfPayee(String nameOfPayee) {
		this.nameOfPayee = nameOfPayee;
	}

	public int getAccount() {
		return this.account;
	}

	public void setAccount(int account) {
		this.account = account;
	}

	public int getBankid() {
		return this.bankid;
	}

	public void setBankid(int bankid) {
		this.bankid = bankid;
	}

	public float getAmount() {
		return this.amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public String getReference() {
		return this.reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public Transfer() {
		// TODO - implement Transfer.Transfer
		throw new UnsupportedOperationException();
	}

	/**
	 * 
	 * @param transferId
	 * @param nameOfPayee
	 * @param account
	 * @param bankid
	 * @param amount
	 * @param reference
	 */
	public Transfer(String transferId, String nameOfPayee, int account, int bankid, float amount, String reference) {
		// TODO - implement Transfer.Transfer
		throw new UnsupportedOperationException();
	}

}