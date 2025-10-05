public class Transfer {

	protected long transfer_id;
	protected String nameOfPayee;
	protected long accNumber;
	protected long bankid;
	protected float amount;
	protected String reference1;
	protected String reference2;
	
	public Transfer(){
		
	}
	
	public Transfer(long transfer_id, String nameOfPayee, long accNumber, long bankid, float amount, String ref1, String ref2){
		this.transfer_id = transfer_id;
		this.nameOfPayee = nameOfPayee;
		this.accNumber = accNumber;
		this.bankid = bankid;
		this.amount = amount;
		this.reference1 = ref1;
		this.reference2 = ref2;
	}
	
	
	public long getTransfer_id() {
		return transfer_id;
	}
	public void setTransfer_id(long transfer_id) {
		this.transfer_id = transfer_id;
	}
	public String getNameOfPayee() {
		return nameOfPayee;
	}
	public void setNameOfPayee(String nameOfPayee) {
		this.nameOfPayee = nameOfPayee;
	}
	public long getAccNumber() {
		return accNumber;
	}
	public void setAccNumber(long accNumber) {
		this.accNumber = accNumber;
	}
	public long getBankid() {
		return bankid;
	}
	public void setBankid(long bankid) {
		this.bankid = bankid;
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}
	public String getReference1() {
		return reference1;
	}
	public void setReference1(String reference1) {
		this.reference1 = reference1;
	}
	public String getReference2() {
		return reference2;
	}
	public void setReference2(String reference2) {
		this.reference2 = reference2;
	}

	

}