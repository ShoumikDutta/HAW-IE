import java.util.Vector;

public class MultipleTransfer extends Transfer {
	private int _TransferNum;
	private Transfer[] _MultTransfer;
	private Vector<Transfer> _MultTransfers = new Vector<Transfer>();
	private Vector<Transfer> _attribute = new Vector<Transfer>();
	private Vector<Transfer> __TransferNum = new Vector<Transfer>();

	public int get_TransferNum() {
		return this._TransferNum;
	}

	public void set_TransferNum(int _TransferNum) {
		this._TransferNum = _TransferNum;
	}

	public Transfer[] get_MultTransfer() {
		return this._MultTransfer;
	}

	public void set_MultTransfer(Transfer[] _MultTransfer) {
		this._MultTransfer = _MultTransfer;
	}

	public MultipleTransfer() {
		throw new UnsupportedOperationException();
	}

	public void AddTransfer(Transfer newTransfer) {
		throw new UnsupportedOperationException();
	}
}