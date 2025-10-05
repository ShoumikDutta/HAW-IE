import java.util.Date;

public class TimeTransfer extends Transfer {

	private Date date;

	


	

	public TimeTransfer() {
		super();
	}

	public TimeTransfer(long transfer_id, String nameOfPayee, long accNumber, long bankid, float amount, String ref1, String ref2){
		super(transfer_id, nameOfPayee, accNumber, bankid, amount, ref1, ref2);
	}


	public Date getDate() {
		return date;
	}



	public void setDate(Date date) {
		this.date = date;
	}

}