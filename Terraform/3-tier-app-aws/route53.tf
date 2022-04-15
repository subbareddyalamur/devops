resource "aws_route53_record" "httpd-alb-dns" {
    zone_id = "aws_route53_zone.main.zone_id" # replace with actual zone_id
    name    = "httpd-alb"
    type    = "A"
    records = [aws_lb.httpd-alb.dns_name]
    alias {
      name = aws_lb.httpd-alb.dns_name
      zone_id = aws_lb.httpd-alb.zone_id
      evaluate_target_health = true
    }
}