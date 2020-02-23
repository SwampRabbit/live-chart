using Gee;

namespace LiveChart {
    
    public class Points : Object {

        private Gee.ArrayList<Point?> points = new Gee.ArrayList<Point?>();
        
        public void add(Point point) {
            points.add(point);
        }

        public int size {
            get {
                return points.size;
            }
        }

        public double realtime_delta {
            get; set;
        }

        public new Point get(int at) {
            return points.get(at);
        }

        public Point after(int at) {
            if (at + 1 >= size) return this.get(size - 1);
            return this.get(at + 1);
        }

        public Point first() {
            return this.get(0);
        }

        public static Points create(Values values, Geometry geometry) {
            var boundaries = geometry.boundaries();

            Points points = new Points();
            var last_value = values.last();
            points.realtime_delta = (((GLib.get_real_time() / 1000) - last_value.timestamp) * geometry.x_ratio) / 1000;

            foreach (TimestampedValue value in values) {
                points.add(Point() {
                    x = (boundaries.x.max - (last_value.timestamp - value.timestamp) / 1000 * geometry.x_ratio) - points.realtime_delta,
                    y = boundaries.y.max - (value.value *  geometry.y_ratio),
                    height = value.value * geometry.y_ratio
                });
            }

            return points;
        }
    }
}