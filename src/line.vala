using Cairo;

namespace LiveChart { 
    public class Line : SerieRenderer {
        private LineDrawer drawer = new LineDrawer();
        public Line(Values values = new Values()) {
            base();
            this.values = values;
        }

        public override void draw(Context ctx, Config config) {
            if (visible) {
                drawer.draw(ctx, config, Points.create(values, config), line);
            }
        }

        protected void draw_line(Points points, Context ctx, Config config) {
            if (visible) {
                drawer.draw_line(points, ctx, config, line);
            }
        }
    }

    public class LineDrawer : Object {

        public void draw(Context ctx, Config config, Points points, Path line) {
            if (points.size > 0) {
                this.draw_line(points, ctx, config, line);
                ctx.stroke();
            }
        }
        public Points draw_line(Points points, Context ctx, Config config, Path line) {
            line.configure(ctx);
            
            var first_point = points.first();

            ctx.move_to(first_point.x, first_point.y);
            for (int pos = 0; pos < points.size -1; pos++) {
                var current_point = points.get(pos);
                var next_point = points.after(pos);
                if (is_out_of_area(current_point)) {
                    ctx.move_to(current_point.x, current_point.y);
                    continue;
                }

                ctx.line_to(next_point.x, next_point.y);
            }

            return points;
        }

        public BoundingBox get_bounding_box(Points points, Config config) {
            return BoundingBox() {
                x=points.first().x,
                y=points.bounds.lower,
                width=points.last().x - points.first().x,
                height=points.bounds.upper - points.bounds.lower
            };
        }
    }
}