1. Starta icecast2 (server, borde vara alltid "på")
	`sudo systemctl status icecast2` (byt ut status till "start" om den inte är igång...)
2. Starta jack daemon
	`jackd -R -n scjack -d dummy -C 0 -P 0 -p 256 &` (använd t.ex. ´jack_lsp -s scjack` för felsökning)
3. Starta darkice
	`darkice -c .darkice.cfg &`
4. Starta react:
	`npm run start` (i react frontend-mapp)
5. Starta flask
	`gunicorn -c gunicorn_config.py app:app`
6. Starta supercollider
	**VIKTIGT**! I "OSCCommunicator.scd" så måste debug-variabeln sättas till "false" (ange detta som ett arg. ist?)
	Först: `export DISPLAY=:0` (går det att köra sclang utan qt? "headless"...)
	`sclang OSCCommunicator.scd -u 7771 -l sclang_conf.yaml`

TODO: göra detta till ett script? 
