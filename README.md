# KMM-config
KMM Webunerako zerbittzaria prestatzeko script-a eta konfigurazio fitxategiak. 
Wegunearen fitxategiak [KMM-Web GitHub biltegitik](https://github.com/Aritzherrero4/KMM-Web) deskargatu eta bere lekuan kokatuko ditu, 
beharrezkoak diren paketeak instalatu eta konfigurazio fitxategiak bere lekura mugituko ditu.

## Nola exekutatu
1. Biltegi hau bikoiztu:
```
git clone https://github.com/Aritzherrero4/KMM-config.git
```

2. Sartu karpetan eta exekuzio baimenak eman config.sh fitxategiari:
```
cd KMM-config
chmod +x config.sh
```

3. Exekutatu config.sh administrazio baimenekin:

```
sudo ./config.sh
```

## Utils
### mp4ToDash.sh
MP4 formatuan dagoen bideo batetik abiatuta, kalitate ezberdineko kopiak sortu eta .mpd manifest fitxategia sortzeko script-a.
Erabilera:
```
./mp4ToDash.sh <bideoa.mp4>
```

## Egileak
Aritz Herrero eta Pablo Corral
