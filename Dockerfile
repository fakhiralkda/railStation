FROM rzlamrr/rail:latest

EXPOSE 80

COPY start.sh .

CMD bash start.sh
