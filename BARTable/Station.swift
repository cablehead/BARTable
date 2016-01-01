import CoreLocation


class Station {
    var code: String
    var desc: String
    var loc: CLLocation

    init(code: String, desc: String, latitude: Double, longitude: Double) {
        self.code = code
        self.desc = desc
        self.loc = CLLocation(
            latitude: latitude, longitude: longitude)
    }

    func distance(loc: CLLocation) -> CLLocationDistance {
        return self.loc.distanceFromLocation(loc)
    }
}


let stations = [
    "24th": Station(
        code: "24th",
        desc: "24th St Mission",
        latitude: 37.752254, longitude: -122.418466),

    "16th": Station(
        code: "16th",
        desc: "16th St Mission",
        latitude: 37.765062, longitude: -122.419694),

    "civc": Station(
        code: "civc",
        desc: "Civic Center",
        latitude: 37.779528, longitude: -122.413756),

    "powl": Station(
        code: "powl",
        desc: "Powell St",
        latitude: 37.784991, longitude: -122.406857),

    "mont": Station(
        code: "mont",
        desc: "Montgomery St",
        latitude: 37.789256, longitude: -122.401407),

    "embr": Station(
        code: "embr",
        desc: "Embarcadero",
        latitude: 37.792976, longitude: -122.396742),
    ]


func closest_station(loc: CLLocation) -> Station {
    var closest: Station?
    for (_, station) in stations {
        if closest == nil {
            closest = station
        } else {
            if station.distance(loc) < closest!.distance(loc) {
                closest = station
            }
        }
    }
    return closest!
}


let stations_order = ["24th", "16th", "civc", "powl", "mont", "embr", ]
