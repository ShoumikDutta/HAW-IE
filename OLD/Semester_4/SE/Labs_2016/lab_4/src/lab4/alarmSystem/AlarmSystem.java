package lab4.alarmSystem;

import java.util.ArrayList;

public class AlarmSystem {
	private final int pinCode;
	private SystemState state = SystemState.INACTIVE;
	private Siren siren = new Siren();
	private ArrayList<Sensor> sensors = new ArrayList<Sensor>();
	
	//��� ����������� ����������, ������� ����� ������� ���� ������� � ������������ ����������
	private static AlarmSystem singleton = null;
	
	//��� ����� ���������� ������� ���������������� Singleton
	public static AlarmSystem Create(int pinCode)
	{
		//����� �� ����� ������� ������� � ������ ��� - ���������� singleton ����� null � ��-����� ��������� ��� singleton = new AlarmSystem(pinCode); 
		if (singleton == null)
		{
			singleton = new AlarmSystem(pinCode); 
			return singleton;
		}
		//����� ����, ��� �� ��������� ��� ��� ������� ����� ������� - ������� ������, ��� ��� ���� ������ � ������ ������ �� ��� ������, �� �������� ����� ������
		else
			return singleton;
	}
	
	//����� ����������� ������� ��������� ��� ����, ����� � ������������ ���� �� ���� ����������� �������������� ��������� ���������� ����� ������
	//���������� ��� ����, ��� �� ����� ���� ������� ������ ���� ��������� �� ���� ������� �����  Create, ������� ������������, ����� ��������� ��� ������ ����
	//����� ��� �������� � ���, ��� ��������� ������, � ��� ����� � ������������, ������������ ������ �������� ������ ���� �� �������� �����-�� ��������� �����
	//���� �� ������� ���������� ������, ������� ����� �������� ����� �����, �� �������� ������� ��� ������� �� ����� - ��� ������� ������������� ������
	//����� ������� ������, ����������� �������� ���������, ����� ������������ ������ ��������� ����������� �����
	//������ ����� � ���� public static AlarmSystem Create(int pinCode)
	private AlarmSystem(int pinCode) {
		this.pinCode = pinCode;
		System.out.println("<System> Created with pin code " + pinCode);
	}
	
	public void addSensor(Sensor sensor) {
		if (!sensors.contains(sensor)) {
			sensors.add(sensor);
			sensor.setAlarmSystem(this);		
			System.out.printf("<System> Added sensor: %s (%s)\n", sensor.getIdentifier(), sensor.getType());
		}
	}

	public void activate() {
		if (state == SystemState.INACTIVE) {
			state = state.nextState(this, SystemState.LEAVING_HOME);
			nextStateDelayed();
		}
	}
	
	public void deactivate(int pinCode) {
		if (pinCode == this.pinCode) {
			state = state.nextState(this, SystemState.INACTIVE);
		} else {
			System.out.println("<System> Incorrect pin code for deactivation: " + pinCode);
		}
	}
	
	public void sensorChanged(Sensor sensor) {
		System.out.printf("<Sensor> %s: %s\n", sensor.getIdentifier(), sensor.getState());
		if ((state == SystemState.ACTIVE) && (sensor.getState() == SensorState.OPEN)) {
			if (sensor.getType() == SensorType.DOOR) {
				state = state.nextState(this, SystemState.COMING_HOME);
				nextStateDelayed();
			} else {
				state = state.nextState(this, SystemState.ALARM);
			}
		}
	}
	
	public void setSirenSoundOn(boolean isSoundOn) {
		siren.setSoundOn(isSoundOn);
		System.out.println("<Siren> Sound on: " + siren.isSoundOn());
	}

	private void nextStateDelayed() {
		DelayThread delay = new DelayThread(this, 10);
		delay.start();
	}
	
	protected void delayExpired() {
		if (state == SystemState.LEAVING_HOME) {
			state = state.nextState(this, SystemState.ACTIVE);
		} else if (state == SystemState.COMING_HOME) {
			state = state.nextState(this, SystemState.ALARM);
		}
	}
}

class DelayThread extends Thread {
	private AlarmSystem parent;
	private int delayInSec;
	
	public DelayThread(AlarmSystem parent, int delayInSec) {
		super();
		this.parent = parent;
		this.delayInSec = delayInSec;
	}

	@Override
	public void run() {
		try {
			sleep(1000L * delayInSec);
		} catch (InterruptedException e) {
		}		
		parent.delayExpired();
	}
}
