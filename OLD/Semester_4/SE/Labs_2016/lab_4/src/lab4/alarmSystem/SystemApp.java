package lab4.alarmSystem;

public class SystemApp {

	private static void delayInSec(int delayInSec) throws InterruptedException {
		Thread.sleep(1000L * delayInSec);
	}
	
	public static void main(String[] args) throws InterruptedException {
		int pinCode = 1234;
		//���� ����� ������� ������ AlarmSystem
		AlarmSystem systemFirst = AlarmSystem.Create(pinCode);
		//� ���� ��� ���, ����� ������� �� ��������� - �� ������ ���������� ������ �� ����� ���������
		//�� ������ �� ��, ��� �� �������� ������� system � ������ �������� � ����� ��������� �� ������ ������� � �������� 2468
		//���������� �� ������ ��������� �� ������� ��������� � ���������� systemFirst � �������� 1234
		AlarmSystem system = AlarmSystem.Create(pinCode*2);
		//�� ����, ��� �� ������� �� ������������� ����������
		//��� ������� ��������� ���� ������ (instance)
		//AlarmSystem system = new AlarmSystem(pinCode);
		//������ ���� ����������� ��������� �������� ���, ������� ����, �� ��������� ������� ��� ���� �������
		//� ������� ������ ������ ��� ��������
		//��� ������� ��������� ������ ������ (instance)
		//AlarmSystem system2 = new AlarmSystem(pinCode);
		Sensor bathSensor = new Sensor("Bathroom", SensorType.WINDOW, SensorState.CLOSED);
		Sensor floorSensor = new Sensor("Floor", SensorType.DOOR, SensorState.CLOSED);
		
		system.addSensor(bathSensor);
		system.addSensor(floorSensor);
		system.activate();

		delayInSec(20);
		floorSensor.changeState();
		
		delayInSec(20);
		system.deactivate(pinCode + 1);
		delayInSec(5);
		system.deactivate(pinCode);
	}
}
