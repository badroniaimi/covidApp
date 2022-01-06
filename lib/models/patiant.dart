
class Patient {

      int? _id;
      String? _mac_address;
      String? _nearBy_id;
      int? _seconds;
      String? _date;
      String? _phoneNumber;

      int? _sick =0;


      Patient( this._mac_address,this._nearBy_id, this._seconds, this._date,this._phoneNumber,this._sick
        );

      //Patient.withId(this._id, this._mac_address, this._date, [this._description]);

      //getters
      int? get id => _id;
      String get mac_address => _mac_address!;
      String? get nearBy_id => _nearBy_id;
      int? get seconds => _seconds;
      int? get sick => _sick;
      String? get phoneNumber => _phoneNumber;
      String? get date => _date;

      //setters
      set mac_address(String newMac) {
        if (newMac.length <= 255) {
          this._mac_address = newMac;
        }
      }


      set nearBy_id(String? value) {
        _nearBy_id = value;
      }

      set seconds(int? newSeconds) {
        _seconds = newSeconds;
      }

      set date(String? newDate) {
        this._date = newDate;
      }

      set sick(int? newSick)
      {
        this._sick=newSick;
      }
      set phoneNumber(String? value) {
        _phoneNumber = value;
      }

      // Convert  into a Map object
      Map<String, dynamic> toMap() {

        var map = Map<String, dynamic>();
        if (id != null) {
          map['id'] = _id;
        }
        map['mac_address'] = _mac_address;
        map['seconds'] = _seconds;
        map['nearBy_id']=_nearBy_id;
        map['date'] = _date;
        map['phone_number']=_phoneNumber;
        map['sick']=_sick;


        return map;
      }

      // reverse map object yto patient object
      Patient.fromMapObject(Map<String, dynamic> map) {
        this._id = map['id'];
        this._mac_address = map['mac_address'];
        this._nearBy_id=map['nearBy_id'];
        this._seconds = map['description'];
        this._phoneNumber=map['phone_number'];
        this._sick=map['sick'];
        this._date = map['date'];

      }


}

