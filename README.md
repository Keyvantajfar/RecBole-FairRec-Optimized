# RecBole-FairRec

![logo](asset/logo.png)

**RecBole-FairRec** is a library toolkit built upon [RecBole](https://recbole.io) for reproducing and developing fairness-aware recommendation.

## Highlights

- **Easy-to-use**: Our library shares unified API and input(atomic files) as RecBole.
- **Conveniently learn and compare**: Our library provides several fairess-metrics and frameworks for learning and comparing.
- **Extensive FairRec library**: Recently proposed fairness-aware algorithms can be easily equipped in our library.

## Requirements

```
torch>=1.7.0
numpy>=1.17.2
scipy==1.6.0
hyperopt>=0.2.4
pandas>=1.0.5
tqdm>=4.48.2
scikit_learn>=0.23.2
pyyaml>=5.1.0
colorlog==4.7.2
colorama==0.4.4
tensorboard>=2.5.0
scikit_learn>=1.0.0
tqdm>=4.0.0
```

## Quick-Start

With the source code, you can use the provided script for initial usage of our library:

```
python run_recbole.py
```
If you want to change the models or datasets, just run the script by setting additional command parameters:
```
python run_recbole.py -m [model] -d [dataset] -c [config_files]
```

## Implement Models

We list the models that we have implemented up to now:

- [FOCF](recbole/model/fair_recommender/focf.py) from Sirui Yao et al:[Beyond Parity：Fairness Objectives for Collaborative Filtering](https://proceedings.neurips.cc/paper/2017/hash/e6384711491713d29bc63fc5eeb5ba4f-Abstract.html)(NIPS 2017). Note: We implement this model with ranking-based metrics, e.g. NDCG@K.
- PFCN from Yunqi Li et al:[Towards Personalized Fairness based on Causal Notion](https://dl.acm.org/doi/abs/10.1145/3404835.3462966?casa_token=zzHePKuKP6AAAAAA:YzZp_qUbzsgd3TXWCAGSRAfEHO2oM0_BuWZ5uZlfj_rudqKGYq8douOaZ0GoizxP54jtz3JDFw725xo)(SIGIR 2021)
  - [PFCN_MLP](recbole/model/fair_recommender/pfcn_mlp.py)
  - [PFCN_BiasedMF](recbole/model/fair_recommender/pfcn_biasedmf.py)
  - [PFCN_DMF](recbole/model/fair_recommender/pfcn_dmf.py)
  - [PFCN_PMF](recbole/model/fair_recommender/pfcn_pmf.py)
- FairGo from Wu Le et al:[Learning Fair Representations for Recommendation: A Graph-based Perspective](https://dl.acm.org/doi/abs/10.1145/3442381.3450015?casa_token=MACP_5U-E6sAAAAA:L-dsEbdusWfmzF06OnATJhF2OXbjfu6el37nC-cGMjev4jGH_TBUedXyAhpfcBMyCyhyxOxLQkxqe_w) (WWW 2021) 
  - [FairGo_PMF(WAP,LBA,LVA)](recbole/model/fair_recommender/fairgo_pmf.py)
  - [FairGo_GCN(WAP,LBA,LVA)](recbole/model/fair_recommender/fairgo_gcn.py)
- [NFCF](recbole/model/fair_recommender/nfcf.py) from Rashidul Islam et al:[Debiasing career recommendations with neural fair collaborative filtering](https://dl.acm.org/doi/abs/10.1145/3442381.3449904?casa_token=ZzbZbC-Fn_oAAAAA:6KCSThLs7UsT9s0ZzeSryT3Mry067KeTiNdurfa9Q9UHWY7fLGgmjPtQy9i1zU1Yqm4Xf46NVYVuu40) (WWW 2021) 

## Datasets

 The datasets used can be downloaded from [Datasets Link](https://drive.google.com/drive/folders/1W6fvJN9ZjuyeqsIuUeodDJk_ajajHkoG).

## LeaderBoard Results

|                    | **GiniIndex** | **PopularityPercentage** |   | **DifferentialFairness** | **ValueUnfairness** | **AbsoluteUnfairness** | **UnderUnfairness** | **OverUnfairness** | **NonParityUnfairness** |   | **NDCG@5** | **Recall@5** | **Hit@5** | **MRR@5** |
|--------------------|---------------|--------------------------|---|--------------------------|---------------------|------------------------|---------------------|--------------------|-------------------------|---|------------|--------------|-----------|-----------|
| **BPR**            | 0.9873        | 0.9991                   |   | 1.493                    | 0.1308              | 0.1024                 | 0.0406              | 0.0903             | 0.0189                  |   | 0.263      | 0.1347       | 0.6518    | 0.4317    |
| **NCF**            | 0.9353        | 0.884                    |   | 1.4781                   | 0.0824(1)           | 0.0548(1)              | 0.0439              | 0.0384             | 0.0101                  |   | 0.4717     | 0.2538       | 0.8972    | 0.6762    |
| **PMF**            | 0.9876        | 0.9766                   |   | 1.5714                   | 0.1293              | 0.1139                 | 0.0203              | 0.109              | 0.0013(2)               |   | 0.2196     | 0.1209       | 0.5944    | 0.3717    |
| **GCN**            | 0.9878        | 0.9291                   |   | 1.5837                   | 0.13                | 0.1177                 | 0.0128              | 0.1172             | 0.01                    |   | 0.1982     | 0.1045       | 0.554     | 0.3428    |
| **BiasedMF**       | 0.9874        | 1                        |   | 1.455                    | 0.127               | 0.0926(3)              | 0.0318              | 0.0952             | 0.0149                  |   | 0.2643     | 0.1381       | 0.6627    | 0.4322    |
| **DMF**            | 0.9167(2)     | 0.8359(2)                |   | 1.4847                   | 0.1055(3)           | 0.0948                 | 0.0083(2)           | 0.0972             | 0.0068                  |   | 0.4882(3)  | 0.2663(3)    | 0.9028(3) | 0.7011    |
| **FOCF_value**     | 0.9875        | 0.9973                   |   | 1.1039(2)                | 0.1275              | 0.1051                 | 0.1107              | 0.0168(2)          | 0.0204                  |   | 0.2422     | 0.1299       | 0.6316    | 0.405     |
| **FOCF_abs**       | 0.9871        | 0.9939                   |   | 1.2727(3)                | 0.1287              | 0.1051                 | 0.1045              | 0.0242(3)          | 0.0061                  |   | 0.2407     | 0.129        | 0.6291    | 0.4034    |
| **FOCF_under**     | 0.9797        | 0.902                    |   | 1.4435                   | 0.1287              | 0.104                  | 0.0295              | 0.0992             | 0.0051                  |   | 0.2375     | 0.1353       | 0.6247    | 0.4055    |
| **FOCF_over**      | 0.9875        | 0.9977                   |   | 1.0641(1)                | 0.1274              | 0.1055                 | 0.1125              | 0.0149(1)          | 0.0297                  |   | 0.2425     | 0.1301       | 0.6325    | 0.4053    |
| **FOCF_nonparity** | 0.9877        | 0.9999                   |   | 1.2878                   | 0.1267              | 0.0895(2)              | 0.071               | 0.0556             | 0.0004(1)               |   | 0.2569     | 0.1381       | 0.6594    | 0.4253    |
| **PFCN_MLP**       | 0.9875        | 1                        |   | 1.5539                   | 0.1283              | 0.1277                 | 0.0003(1)           | 0.128              | 0.0035                  |   | 0.2621     | 0.1371       | 0.6578    | 0.4309    |
| **PFCN_BiasedMF**  | 0.9874        | 1                        |   | 1.4821                   | 0.1283              | 0.0984                 | 0.0395              | 0.0888             | 0.0071                  |   | 0.2644     | 0.1384       | 0.6629    | 0.434     |
| **PFCN_DMF**       | 0.9873        | 1                        |   | 1.5357                   | 0.1277              | 0.1071                 | 0.0284              | 0.0993             | 0.0018(3)               |   | 0.2578     | 0.1351       | 0.654     | 0.422     |
| **PFCN_PMF**       | 0.9873        | 1                        |   | 1.4272                   | 0.1261              | 0.096                  | 0.0223              | 0.1038             | 0.0101                  |   | 0.2608     | 0.1374       | 0.6642    | 0.4296    |
| **FairGo_PMF_WAP** | 0.9822        | 0.9283                   |   | 1.5781                   | 0.1321              | 0.1171                 | 0.0166              | 0.1156             | 0.0057                  |   | 0.2187     | 0.1283       | 0.5922    | 0.3691    |
| **FairGo_PMF_LVA** | 0.9822        | 0.9232                   |   | 1.5824                   | 0.1321              | 0.1198                 | 0.0143              | 0.1179             | 0.007                   |   | 0.2127     | 0.1199       | 0.5781    | 0.3651    |
| **FairGo_PMF_LBA** | 0.9821        | 0.9024                   |   | 1.5842                   | 0.1322              | 0.1203                 | 0.0139              | 0.1183             | 0.0056                  |   | 0.2109     | 0.1156       | 0.577     | 0.3624    |
| **FairGo_GCN_WAP** | 0.9881        | 0.9161                   |   | 1.5783                   | 0.1304              | 0.1156                 | 0.0175              | 0.1128             | 0.0081                  |   | 0.1699     | 0.0968       | 0.5051    | 0.3024    |
| **FairGo_GCN_LVA** | 0.9881        | 0.9819                   |   | 1.5841                   | 0.1304              | 0.118                  | 0.0143              | 0.1161             | 0.0051                  |   | 0.1939     | 0.1111       | 0.552     | 0.3252    |
| **FairGo_GCN_LBA** | 0.9881        | 0.9821                   |   | 1.5841                   | 0.1304              | 0.118                  | 0.0143              | 0.1161             | 0.0051                  |   | 0.1938     | 0.1111       | 0.5518    | 0.3251    |
| **NCF_MLP**        | 0.9035(1)     | 0.8206(1)                |   | 1.5627                   | 0.1054(2)           | 0.0942                 | 0.009               | 0.0965             | 0.0043                  |   | 0.5051(1)  | 0.2756(1)    | 0.9154(1) | 0.7109    |
| **NFCF**           | 0.9193(3)     | 0.8628(3)                |   | 1.5366                   | 0.1151              | 0.0974                 | 0.0133              | 0.1018             | 0.0045                  |   | 0.4927(2)  | 0.2693(2)    | 0.9094(2) | 0.7022    |

## The Team
RecBole-FairRec is developed and maintained by Jiakai Tang ([@Tangjiakai](https://github.com/TangJiakai)).

## Acknowledgement

The implementation is based on the open-source recommendation library [RecBole](https://github.com/RUCAIBox/RecBole).

Please cite the following paper as the reference if you use our code or processed datasets.

```
@inproceedings{zhao2021recbole,
  title={Recbole: Towards a unified, comprehensive and efficient framework for recommendation algorithms},
  author={Wayne Xin Zhao and Shanlei Mu and Yupeng Hou and Zihan Lin and Kaiyuan Li and Yushuo Chen and Yujie Lu and Hui Wang and Changxin Tian and Xingyu Pan and Yingqian Min and Zhichao Feng and Xinyan Fan and Xu Chen and Pengfei Wang and Wendi Ji and Yaliang Li and Xiaoling Wang and Ji-Rong Wen},
  booktitle={{CIKM}},
  year={2021}
}
