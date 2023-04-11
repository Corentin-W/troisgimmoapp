import 'package:flutter/material.dart';
import '../models/annonce.dart';

class Annonces extends StatefulWidget {
  const Annonces({super.key});

  @override
  State<Annonces> createState() => _AnnoncesState();
}

class _AnnoncesState extends State<Annonces> {
  List<Annonce> allAnnonces = [
    Annonce(
        prix: 100000,
        surface: 28,
        honoraires: 1500,
        type: 'Appartement',
        linkPhoto:
            'https://www.3gimmobilier.com/photo_bien.php?id=1462394807&nb=1&r=524354021',
        villeDiffusion: 'Annecy'),
    Annonce(
        prix: 300000,
        surface: 88,
        honoraires: 1500,
        type: 'Maison',
        linkPhoto:
            'https://www.3gimmobilier.com/photos_biens/2023/04/03/171501/171501vp_appart_74940_annecy_10.jpg',
        villeDiffusion: 'Toulouse'),
    Annonce(
        prix: 1505000,
        surface: 228,
        honoraires: 11500,
        type: 'Villa',
        linkPhoto:
            'https://www.3gimmobilier.com/photos_biens/2023/04/03/171524/171524fm_maison_56690_nostang_01.jpg',
        villeDiffusion: 'Saint-Jorioz'),
    Annonce(
        prix: 9860000,
        surface: 128,
        honoraires: 8500,
        type: 'Maison / Villa',
        linkPhoto:
            'https://www.3gimmobilier.com/photos_biens/2022/11/15/166193/166193sd_maison_40510_seignosse_01.jpg',
        villeDiffusion: 'Bordeaux'),
    Annonce(
        prix: 830750,
        surface: 78,
        honoraires: 10500,
        type: 'Maison',
        linkPhoto:
            'https://www.3gimmobilier.com/photos_biens/2023/03/29/171257/171257jc_maison_77590_bois_le_roi_02.jpg',
        villeDiffusion: 'Rennes'),
    Annonce(
        prix: 100000,
        surface: 28,
        honoraires: 1500,
        type: 'Appartement',
        linkPhoto:
            'https://www.3gimmobilier.com/photo_bien.php?id=1462394807&nb=1&r=524354021',
        villeDiffusion: 'Annecy'),
    Annonce(
        prix: 300000,
        surface: 88,
        honoraires: 1500,
        type: 'Maison',
        linkPhoto:
            'https://www.3gimmobilier.com/photos_biens/2023/04/03/171501/171501vp_appart_74940_annecy_10.jpg',
        villeDiffusion: 'Toulouse'),
    Annonce(
        prix: 1505000,
        surface: 228,
        honoraires: 11500,
        type: 'Villa',
        linkPhoto:
            'https://www.3gimmobilier.com/photos_biens/2023/04/03/171524/171524fm_maison_56690_nostang_01.jpg',
        villeDiffusion: 'Saint-Jorioz'),
    Annonce(
        prix: 9860000,
        surface: 128,
        honoraires: 8500,
        type: 'Maison / Villa',
        linkPhoto:
            'https://www.3gimmobilier.com/photos_biens/2022/11/15/166193/166193sd_maison_40510_seignosse_01.jpg',
        villeDiffusion: 'Bordeaux'),
    Annonce(
        prix: 830750,
        surface: 78,
        honoraires: 10500,
        type: 'Maison',
        linkPhoto:
            'https://www.3gimmobilier.com/photos_biens/2023/03/29/171257/171257jc_maison_77590_bois_le_roi_02.jpg',
        villeDiffusion: 'Rennes'),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scrollbar(
          child: ListView.builder(
              itemCount: allAnnonces.length,
              itemBuilder: (BuildContext context, int index) {
                return allAnnonces[index].cardAnnonce(
                    image: allAnnonces[index].linkPhoto,
                    type: allAnnonces[index].type,
                    honoraires: allAnnonces[index].honoraires,
                    prix: allAnnonces[index].prix,
                    surface: allAnnonces[index].surface,
                    villeDiffusion: allAnnonces[index].villeDiffusion);
              })),
    );
  }
}
