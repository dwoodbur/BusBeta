
import MapKit

class Station: NSObject, MKAnnotation, MKMapViewDelegate {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude:Double
   
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func pinColor() ->MKPinAnnotationColor{
        return .Green
    }
 
}
