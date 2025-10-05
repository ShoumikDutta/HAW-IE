import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;


public class TestFrame extends JFrame {

	private JPanel contentPane;
	private JTextField txtTransferIdInput;
	private JTextField txtTransferDayInput;
	private JTextField txtNameInput;
	private JTextField txtAccInput;
	private JTextField txtIdInput;
	private JTextField txtAmountInput;
	private JTextField txtRefInput;
	private JTextField txtRefInput_1;
	private JLabel lblTransferId;
	private JLabel lblTransferDay;
	private JLabel lblTransferIdOutput;
	private JLabel lblNameOfPayee;
	private JLabel lblBankAccount;
	private JLabel lblBankId;
	private JLabel lblAmount;
	private JLabel lblReference;
	private JLabel lblReference_1;
	private JLabel lblNameOutput;
	private JLabel lblAccOutput;
	private JLabel lblIdOutput;
	private JLabel lblAmountOutput;
	private JLabel lblRefOutput;
	private JLabel lblRefOutput_1;
	private JButton btnAccept;
	private JButton btnShow;
	private JButton btnNext;
	private JButton btnClear;
	private JButton btnMultipletransfer;
	private JButton btnTimetransfer;
	private JButton btnTransfer;
	private JLabel lblSelectTransferType;
	private JLabel lblErrorMessage;
	private boolean transferPressed;
	private boolean timeTransferPressed;
	private boolean multipleTransferPressed;

	private static User user;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {

		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					TestFrame frame = new TestFrame();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
		user = new User();
	}

	/**
	 * Create the frame.
	 */
	public TestFrame() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 577, 357);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);

		lblSelectTransferType = new JLabel("select transfer type");
		lblSelectTransferType.setBounds(10, 11, 95, 14);
		contentPane.add(lblSelectTransferType);

		btnTransfer = new JButton("transfer");
		btnTransfer.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				transferPressed = true;
				timeTransferPressed = false;
				multipleTransferPressed = false;
				lblTransferDay.setVisible(false);
				txtTransferDayInput.setVisible(false);
				btnNext.setVisible(false);
			}
		});
		btnTransfer.setBounds(115, 7, 95, 23);
		contentPane.add(btnTransfer);

		btnTimetransfer = new JButton("timetransfer");
		btnTimetransfer.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				transferPressed = false;
				timeTransferPressed = true;
				multipleTransferPressed = false;
				lblTransferDay.setVisible(true);
				txtTransferDayInput.setVisible(true);
				btnNext.setVisible(false);
			}
		});
		btnTimetransfer.setBounds(220, 7, 111, 23);
		contentPane.add(btnTimetransfer);

		btnMultipletransfer = new JButton("multipletransfer");
		btnMultipletransfer.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				transferPressed = false;
				timeTransferPressed = false;
				multipleTransferPressed = true;
				lblTransferDay.setVisible(true);
				txtTransferDayInput.setVisible(true);
				btnNext.setVisible(true);
			}
		});
		btnMultipletransfer.setBounds(341, 7, 133, 23);
		contentPane.add(btnMultipletransfer);

		lblTransferId = new JLabel("transfer ID");
		lblTransferId.setBounds(10, 58, 60, 14);
		contentPane.add(lblTransferId);

		txtTransferIdInput = new JTextField();
		//txtTransferIdInput.setText("transfer ID input");
		txtTransferIdInput.setBounds(80, 55, 86, 20);
		contentPane.add(txtTransferIdInput);
		txtTransferIdInput.setColumns(10);

		lblTransferIdOutput = new JLabel("");
		lblTransferIdOutput.setBounds(176, 58, 70, 14);
		contentPane.add(lblTransferIdOutput);

		lblTransferDay = new JLabel("<html>Transfer day /<br>no. of transfers");
		lblTransferDay.setBounds(267, 41, 111, 51);
		contentPane.add(lblTransferDay);

		txtTransferDayInput = new JTextField();
		//txtTransferDayInput.setText("transfer day input");
		txtTransferDayInput.setBounds(388, 55, 86, 20);
		contentPane.add(txtTransferDayInput);
		txtTransferDayInput.setColumns(10);

		txtNameInput = new JTextField();
		//txtNameInput.setText("name input");
		txtNameInput.setBounds(19, 100, 147, 20);
		contentPane.add(txtNameInput);
		txtNameInput.setColumns(10);

		txtAccInput = new JTextField();
		//txtAccInput.setText("acc input");
		txtAccInput.setBounds(80, 131, 86, 20);
		contentPane.add(txtAccInput);
		txtAccInput.setColumns(10);

		txtIdInput = new JTextField();
		//txtIdInput.setText("id input");
		txtIdInput.setBounds(80, 162, 86, 20);
		contentPane.add(txtIdInput);
		txtIdInput.setColumns(10);

		txtAmountInput = new JTextField();
		//txtAmountInput.setText("amount input");
		txtAmountInput.setBounds(106, 193, 60, 20);
		contentPane.add(txtAmountInput);
		txtAmountInput.setColumns(10);

		txtRefInput = new JTextField();
		//txtRefInput.setText("ref1 input");
		txtRefInput.setBounds(19, 224, 147, 20);
		contentPane.add(txtRefInput);
		txtRefInput.setColumns(10);

		txtRefInput_1 = new JTextField();
		//txtRefInput_1.setText("");
		txtRefInput_1.setBounds(19, 255, 147, 20);
		contentPane.add(txtRefInput_1);
		txtRefInput_1.setColumns(10);

		lblNameOfPayee = new JLabel("name of payee");
		lblNameOfPayee.setBounds(176, 103, 117, 14);
		contentPane.add(lblNameOfPayee);

		lblBankAccount = new JLabel("bank account");
		lblBankAccount.setBounds(176, 134, 117, 14);
		contentPane.add(lblBankAccount);

		lblBankId = new JLabel("bank ID");
		lblBankId.setBounds(176, 165, 117, 14);
		contentPane.add(lblBankId);

		lblAmount = new JLabel("amount");
		lblAmount.setBounds(176, 196, 117, 14);
		contentPane.add(lblAmount);

		lblReference = new JLabel("reference 1");
		lblReference.setBounds(176, 227, 117, 14);
		contentPane.add(lblReference);

		lblReference_1 = new JLabel("reference 2");
		lblReference_1.setBounds(176, 258, 109, 14);
		contentPane.add(lblReference_1);

		lblNameOutput = new JLabel("");
		lblNameOutput.setBounds(303, 103, 171, 14);
		contentPane.add(lblNameOutput);

		lblAccOutput = new JLabel("");
		lblAccOutput.setBounds(303, 134, 156, 14);
		contentPane.add(lblAccOutput);

		lblIdOutput = new JLabel("");
		lblIdOutput.setBounds(303, 165, 46, 14);
		contentPane.add(lblIdOutput);

		lblAmountOutput = new JLabel("");
		lblAmountOutput.setBounds(303, 196, 138, 14);
		contentPane.add(lblAmountOutput);

		lblRefOutput = new JLabel("");
		lblRefOutput.setBounds(303, 227, 161, 14);
		contentPane.add(lblRefOutput);

		lblRefOutput_1 = new JLabel("");
		lblRefOutput_1.setBounds(303, 258, 161, 14);
		contentPane.add(lblRefOutput_1);

		btnAccept = new JButton("accept");
		btnAccept.addActionListener(new ActionListener(){

			@Override
			public void actionPerformed(ActionEvent e) {
				if(txtAccInput.getText().equals("") || txtAmountInput.getText().equals("") || txtIdInput.getText().equals("") || txtNameInput.getText().equals("") || txtTransferIdInput.getText().equals("")){
					lblErrorMessage.setText("Please, fill all necessary fields");
					return;
				}
				if(transferPressed){
					try{
					user.setTransfer(new Transfer(Long.valueOf(txtTransferIdInput.getText()), txtNameInput.getText(), Long.valueOf(txtAccInput.getText()), Long.valueOf(txtIdInput.getText()), Float.valueOf(txtAmountInput.getText()), txtRefInput.getText(), txtRefInput_1.getText()));
					clear();
					}
					catch(NumberFormatException numbException){
						lblErrorMessage.setText("Please, fill fields correctly");
					}
				}
				else if(multipleTransferPressed){
					try{
					user.getMultTransfer().addTransfer(new Transfer(Long.valueOf(txtTransferIdInput.getText()), txtNameInput.getText(), Long.valueOf(txtAccInput.getText()), Long.valueOf(txtIdInput.getText()), Float.valueOf(txtAmountInput.getText()), txtRefInput.getText(), txtRefInput_1.getText()));
					clear();
					}
					catch(NumberFormatException numbException){
						lblErrorMessage.setText("Please, fill fields correctly");
					}
				}
				else if(timeTransferPressed){
					if(txtTransferDayInput.getText().equals("")){
						lblErrorMessage.setText("Set the Date please");
						return;
					}
					SimpleDateFormat dateString = new SimpleDateFormat("yyyy-MM-dd");
					try{
						Date date = dateString.parse(txtTransferDayInput.getText());
						user.getTimeTransfer().setDate(date);
					}
					catch(ParseException parseException){
						lblErrorMessage.setText("Please set Time as: yyyy-mm-dd");
						return;
					}
					clear();
				}
				
			}
			
		});
		btnAccept.setBounds(10, 296, 88, 23);
		contentPane.add(btnAccept);

		btnShow = new JButton("show");
		btnShow.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				showFrame();


			}
		});
		btnShow.setBounds(108, 296, 76, 23);
		contentPane.add(btnShow);

		btnNext = new JButton("next");
		btnNext.addActionListener(new ActionListener(){

			@Override
			public void actionPerformed(ActionEvent e) {
				try{
				Transfer transfer = new Transfer(Long.valueOf(txtTransferIdInput.getText()), txtNameInput.getText(), Long.valueOf(txtAccInput.getText()), Long.valueOf(txtIdInput.getText()), Float.valueOf(txtAmountInput.getText()), txtRefInput.getText(), txtRefInput_1.getText());
				user.getMultTransfer().addTransfer(transfer);
				txtTransferDayInput.setText(String.valueOf(user.getMultTransfer().getNumberOfTransfers()));
				clear();
				}
				catch(NumberFormatException numbException){
					lblErrorMessage.setText("Please, fill fields correctly");
				}
			}

		});
		btnNext.setBounds(194, 296, 91, 23);
		contentPane.add(btnNext);

		btnClear = new JButton("clear");
		btnClear.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				clear();
			}
		});
		btnClear.setBounds(295, 296, 83, 23);
		contentPane.add(btnClear);

		lblErrorMessage = new JLabel("ERROR MESSAGE");
		lblErrorMessage.setBounds(388, 300, 163, 14);
		contentPane.add(lblErrorMessage);
	}
	private void clear(){
		lblTransferIdOutput.setText("");
		lblNameOutput.setText("");
		lblAccOutput.setText("");
		lblIdOutput.setText("");
		lblAmountOutput.setText("");
		lblRefOutput.setText("");
		lblRefOutput_1.setText("");
		txtTransferIdInput.setText("");
		txtNameInput.setText("");
		txtAccInput.setText("");
		txtIdInput.setText("");
		txtAmountInput.setText("");
		txtRefInput.setText("");
		txtRefInput_1.setText("");
		txtTransferDayInput.setText("");

	}

	private void showFrame(){
		lblTransferIdOutput.setText(txtTransferIdInput.getText());
		lblNameOutput.setText(txtNameInput.getText());
		lblAccOutput.setText(txtAccInput.getText());
		lblIdOutput.setText(txtIdInput.getText());
		lblAmountOutput.setText(txtAmountInput.getText());
		lblRefOutput.setText(txtRefInput.getText());
		lblRefOutput_1.setText(txtRefInput_1.getText());
	}
}
