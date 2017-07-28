//
//  GithubViewController.swift
//  SwiftSVGExamples
//
//  Copyright (c) 2017 Michael Choe
//  http://www.github.com/mchoe
//  http://www.straussmade.com/
//  http://www.twitter.com/_mchoe
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.



import SwiftSVG
import UIKit

class GithubViewController: UIViewController {
    
    
    struct CellItem {
        let render: (CGSize) -> UIView
    }
    
    lazy var collectionViewData: [CellItem] = {
        let returnData = [
            CellItem(render: { (cellSize) -> UIView in
                
                // Simplest example of an SVG stored in the main bundle
                
                let svgView = UIView(SVGNamed: "fistBump")
                return svgView
            }),
            CellItem(render: { (cellSize) -> UIView in
                
                // Parsing a single path string syncronously
                
                let triangle = UIView(pathString: "M75 0 l75 200 L0 200 Z")
                return triangle
            }),
            CellItem(render: { (cellSize) -> UIView in
                
                let svgURL = URL(string: "https://openclipart.org/download/181651/manhammock.svg")!
                let hammock = UIView(SVGURL: svgURL) { (svgLayer) in
                    svgLayer.fillColor = UIColor(red:0.52, green:0.16, blue:0.32, alpha:1.00).cgColor
                    svgLayer.resizeToFit(CGRect(x: 0, y: 0, width: cellSize.width, height: cellSize.height))
                }
                return hammock
            }),
            CellItem(render: { (cellSize) -> UIView in
                
                let returnView = UIView()
                let svgURL = Bundle.main.url(forResource: "pizza", withExtension: "svg")!
                let pizza = CALayer(SVGURL: svgURL) { (svgLayer) in
                    // Set the fill color
                    svgLayer.fillColor = UIColor(red:0.94, green:0.37, blue:0.00, alpha:1.00).cgColor
                    // Aspect fit the layer to self.view
                    svgLayer.resizeToFit(CGRect(x: 0, y: 0, width: cellSize.width, height: cellSize.height))
                    // Add the layer to self.view's sublayers
                    returnView.layer.addSublayer(svgLayer)
                }
                return returnView
            }),
            CellItem(render: { (cellSize) -> UIView in
                
                let sockPuppet = "M49.976,36.57l27.343,1.078c7.437,0,13.486-6.05,13.486-13.487s-6.049-13.487-13.485-13.487H58  c-0.429-3.546-2.45-6.235-4.881-6.235s-4.45,2.689-4.877,6.235h-4.368c-0.259,0-0.511,0.01-0.768,0.014  c-0.423-3.553-2.445-6.25-4.88-6.25c-2.719,0-4.924,3.36-4.961,7.523c-5.139,1.369-9.419,3.825-12.781,7.357  c-8.476,8.907-7.963,21.297-7.939,21.737v37.496h4.016V93.5h33.775V78.551h4.471v-1.682c0-8.529,4.16-9.612,4.639-9.708  c0.794-0.026,5.409-0.225,10.103-1.41c9.184-2.323,11.111-6.586,11.111-9.753c0-7.207-5.377-9.775-10.409-9.775  c-0.399,0-0.689,0.018-0.829,0.028H51.104l-0.237,0.017c-0.004,0.001-0.422,0.058-1.042,0.058c-5.218,0-5.218-3.253-5.218-4.322  C44.607,36.887,49.143,36.58,49.976,36.57z M87.441,24.161c0,5.583-4.542,10.124-10.057,10.125l-7.973-0.314  c-4.428-6.087-6.037-11.196-4.771-15.199c0.722-2.282,2.289-3.793,3.675-4.734h9.002C82.899,14.038,87.441,18.579,87.441,24.161z   M69.492,49.615l0.16-0.008c0.035-0.003,0.254-0.021,0.598-0.021c2.632,0,7.046,0.833,7.046,6.412c0,4.667-8.069,6.723-13.864,7.461  c-1.008-0.493-1.786-1.215-2.318-2.167c-1.917-3.429-0.405-8.997,0.517-11.677H69.492z M49.825,49.689  c0.655,0,1.153-0.047,1.384-0.074h9.357c-0.98,2.923-2.377,8.495-0.327,12.164c0.412,0.737,0.946,1.354,1.591,1.858  c-1.001,0.095-1.887,0.147-2.579,0.164l-0.153,0.012c-0.297,0.034-6.954,0.932-7.604,11.374H45.15v-7.053h-3.364v7.053H35.06v-7.053  h-3.363v7.053h-7.147v-7.053h-3.364v7.053h-5.277l-0.002-34.212c-0.005-0.115-0.447-11.52,7.037-19.36  c2.829-2.964,6.458-5.042,10.805-6.269c0.799,2.571,2.501,4.353,4.479,4.353c2.291,0,4.215-2.388,4.788-5.63  c0.291-0.005,0.565-0.031,0.86-0.031h22.781c-1.188,1.029-2.341,2.46-2.964,4.421c-1.327,4.175,0.18,9.371,4.46,15.462  l-18.109-0.714c-3.043,0-8.798,1.838-8.798,8.797C41.244,46.816,44.452,49.689,49.825,49.689z"
                let sockPuppetSVG = CAShapeLayer(pathString: sockPuppet)
                let returnView = UIView()
                returnView.layer.addSublayer(sockPuppetSVG)
                return returnView
            }),
            CellItem(render: { (cellSize) -> UIView in
                
                let tea = "M166.467916,125.61975 C163.212238,131.944462 153.253694,144.977204 125.484677,151.685233 C123.761082,154.368444 115.143112,162.801395 83.5438847,162.801395 C62.8607545,162.801395 52.3276789,159.351552 46.7738754,156.093366 C44.4757498,158.201604 41.9861137,159.926525 38.9219463,161.076473 L40.2625195,164.717975 C40.8370509,166.442896 39.8794986,168.359476 38.1559044,168.93445 L27.4313183,172.767609 C25.7077241,173.342583 23.7926195,172.384293 23.2180881,170.659372 L20.1539206,161.843105 C19.5793893,160.118183 20.5369416,158.201604 22.2605358,157.62663 L32.9851218,153.793471 C34.708716,153.218497 36.6238207,154.176786 37.1983521,155.901708 L38.3474149,159.159894 C41.0285614,158.201604 43.1351765,156.66834 45.0502812,154.943418 C43.326687,153.410155 42.3691346,152.260207 41.7946032,151.493575 C14.2170962,144.40223 4.83308341,130.986173 1.96042643,124.853118 C1.19438457,123.70317 0.811363636,122.553222 0.811363636,121.403274 C0.811363636,114.695246 12.1104811,109.520481 34.3256951,106.070637 C23.98413,85.7548928 26.473766,64.4808586 26.473766,64.0975427 C26.8567869,53.5563546 56.1578882,47.8066156 83.7353952,47.8066156 C111.312902,47.8066156 140.614003,53.5563546 140.997024,64.0975427 C141.188535,64.0975427 141.380045,66.7807542 141.380045,71.1888874 C145.210255,70.4222555 152.679163,69.4639657 158.041456,73.297125 C161.871665,76.1719945 163.78677,80.7717857 163.78677,87.2881565 C163.78677,95.3377911 160.339581,103.770742 153.445205,110.095454 C163.212238,112.970324 168,116.803483 168,121.594932 C168,123.128196 167.425469,124.469802 166.467916,125.61975 Z M164.935833,121.594932 C164.744322,118.145089 159.76505,115.078562 150.572548,112.587008 C144.061192,117.378457 135.0602,120.636643 123.186551,120.8283 C119.930873,124.278144 116.100664,127.536329 111.504413,130.411199 C109.206287,131.944462 107.482693,134.436016 106.908162,137.119228 C136.975305,135.202648 158.232966,129.836225 163.595259,124.469802 C164.361301,122.936538 164.744322,121.978248 164.935833,121.594932 Z M60.7541393,64.6725166 L55.9663777,75.4053626 C56.5409091,75.5970206 57.306951,75.7886786 57.8814823,75.7886786 C61.5201812,67.930702 68.9890893,64.8641745 73.2023196,63.7142267 C73.3938301,62.7559369 74.3513824,61.989305 75.5004452,61.989305 C76.8410184,61.989305 77.9900812,63.1392528 77.9900812,64.4808586 C77.9900812,65.8224643 76.8410184,66.9724121 75.5004452,66.9724121 C74.7344033,66.9724121 73.9683614,66.5890962 73.5853405,66.0141223 C69.7551312,66.9724121 63.2437754,69.6556237 59.9880975,76.3636525 C67.0739847,77.3219423 75.1174242,77.8969162 83.9269057,77.8969162 C91.3958138,77.8969162 98.2901906,77.5136003 104.418525,76.9386264 L100.779827,64.8641745 L87.9486254,56.622882 L60.7541393,64.6725166 Z M65.9249219,99.5542663 C64.5499339,99.5542663 63.4352858,98.4387598 63.4352858,97.0627127 C63.4352858,95.6866657 64.5499339,94.5711592 65.9249219,94.5711592 C67.2999099,94.5711592 68.414558,95.6866657 68.414558,97.0627127 C68.414558,98.4387598 67.2999099,99.5542663 65.9249219,99.5542663 Z M73.0108091,99.3626083 C74.1598719,99.3626083 75.3089347,100.320898 75.3089347,101.662504 L106.716651,92.6545795 L111.887434,109.328823 L69.5636207,122.361564 L64.3928382,104.920689 L70.904194,103.00411 C70.7126835,102.620794 70.5211731,102.237478 70.5211731,101.854162 C70.5211731,100.512556 71.6702359,99.3626083 73.0108091,99.3626083 Z M77.9900812,98.0210026 C77.2240394,97.8293446 76.4579975,97.0627127 76.266487,96.2960809 C75.6919556,94.5711592 77.4155498,93.0378955 79.139144,93.4212114 C79.9051859,93.6128694 80.6712277,94.3795012 80.8627382,95.1461331 C81.4372696,96.8710548 79.7136754,98.4043185 77.9900812,98.0210026 Z M71.2872149,91.5046317 C70.3296626,91.3129738 69.5636207,90.5463419 69.5636207,89.77971 C68.9890893,88.0547884 70.7126835,86.5215246 72.4362777,86.9048406 C73.2023196,87.0964985 73.9683614,87.8631304 74.1598719,88.6297623 C74.7344033,90.3546839 73.0108091,91.8879477 71.2872149,91.5046317 Z M87.5656045,95.721107 C86.6080522,95.529449 85.8420103,94.7628172 85.8420103,93.9961853 C85.2674789,92.2712636 86.9910731,90.7379999 88.7146673,91.1213158 C89.4807092,91.3129738 90.246751,92.0796056 90.4382615,92.8462375 C91.0127929,94.5711592 89.2891987,96.1044229 87.5656045,95.721107 Z M83.9269057,80.9634436 C75.3089347,80.9634436 66.6909638,80.3884697 58.6475242,79.2385219 C58.0729928,81.7300755 57.4984614,84.413287 57.306951,87.4798145 L68.414558,124.853118 L114.56858,111.053744 L105.376078,79.8134958 C98.481701,80.5801277 91.2043033,80.9634436 83.9269057,80.9634436 Z M56.5409091,130.602857 C56.3493986,132.711094 56.1578882,134.627674 55.7748672,136.544254 C57.4984614,136.735912 59.0305451,136.735912 60.7541393,136.92757 C60.1796079,134.436016 58.6475242,132.13612 56.5409091,130.602857 Z M64.0098172,137.119228 C70.5211731,137.502543 77.2240394,137.694201 84.5014371,137.694201 C91.3958138,137.694201 97.7156592,137.502543 103.843994,137.119228 C104.418525,133.286068 106.525141,129.836225 109.972329,127.727987 C136.017752,111.053744 138.507388,81.7300755 138.507388,70.4222555 C133.336606,75.0220467 121.845978,78.2802321 108.440245,80.0051538 L110.738371,88.0547884 C113.994049,87.6714724 121.654467,86.9048406 127.399781,84.9882609 C129.314886,84.221629 131.03848,85.7548928 130.655459,87.6714724 C128.740355,96.2960809 123.952593,111.053744 111.312902,121.019958 C111.312902,121.019958 107.865714,123.128196 105.184567,126.003066 C100.013785,131.561147 92.7363871,132.711094 85.0759684,132.711094 L84.1184161,132.711094 C77.7985708,132.711094 71.6702359,131.944462 66.6909638,128.877935 L66.4994533,128.877935 L66.3079428,128.494619 C65.15888,127.727987 64.2013277,126.961355 63.2437754,126.003066 C61.7116917,124.469802 59.796587,123.128196 57.4984614,121.78659 C57.306951,121.78659 57.306951,121.594932 57.1154405,121.594932 C57.1154405,123.511512 57.1154405,125.236434 56.92393,127.153013 C57.306951,127.344671 57.4984614,127.536329 57.8814823,127.727987 C61.1371603,129.836225 63.4352858,133.286068 64.0098172,137.119228 Z M139.847962,86.5215246 C138.698899,92.8462375 136.592284,99.9375822 132.953585,106.645611 L137.358326,105.112347 C142.912129,103.195768 147.50838,99.1709504 149.614995,93.9961853 C150.955569,90.9296578 151.33859,87.8631304 150.572548,86.1382087 C150.189527,85.3715768 149.806506,84.7966029 149.040464,84.604945 C145.018744,83.2633392 140.997024,85.7548928 139.847962,86.5215246 Z M156.126351,75.9803365 C151.5301,72.5304931 144.252702,73.8720989 141.380045,74.6387308 C141.188535,77.1302843 140.997024,79.8134958 140.614003,82.6883653 C142.912129,81.5384175 146.359317,80.5801277 150.189527,81.9217335 C151.72161,82.4967074 152.870673,83.4549972 153.445205,84.9882609 C154.594267,87.4798145 154.211246,91.3129738 152.487652,95.3377911 C149.998016,101.279188 144.827234,105.878979 138.507388,108.178875 L130.655459,111.053744 C129.314886,113.161982 127.782802,115.461877 126.059208,117.570115 C149.806506,116.036851 160.722602,101.08753 160.722602,87.4798145 C160.722602,81.9217335 159.190519,78.0885741 156.126351,75.9803365 Z M83.9269057,51.064801 C51.9446579,51.064801 29.7294439,58.1561457 29.5379335,64.2892006 C29.5379335,66.3974382 32.0275695,68.6973338 36.6238207,70.6139135 C37.0068416,68.8889918 38.9219463,66.0141223 47.1568963,64.4808586 C49.4550219,64.0975427 53.2852312,63.5225688 58.0729928,63.1392528 L58.6475242,61.989305 L88.5231568,53.1730386 L103.460973,62.7559369 L103.652484,63.1392528 C115.717643,64.2892006 125.867698,66.9724121 129.123376,71.5722033 C134.868689,69.4639657 138.124367,66.9724121 138.124367,64.4808586 C138.124367,58.1561457 115.717643,51.064801 83.9269057,51.064801 Z M29.346423,69.8472816 C29.346423,81.3467596 31.4530381,108.753849 54.6258044,126.003066 C54.8173149,123.511512 54.8173149,120.8283 54.8173149,118.145089 L54.8173149,111.053744 L54.8173149,103.387426 C54.6258044,94.1878433 54.8173149,85.5632348 56.5409091,79.4301799 C55.9663777,79.2385219 55.2003358,79.2385219 54.6258044,79.046864 C54.051273,80.9634436 53.6682521,83.2633392 53.4767416,85.7548928 L51.3701265,78.4718901 L51.3701265,78.2802321 C41.4115823,76.3636525 33.3681428,73.488783 29.346423,69.8472816 Z M36.0492893,109.137165 C12.876523,112.587008 4.25855201,117.761773 4.25855201,121.594932 C4.45006248,121.978248 4.83308341,122.74488 5.40761481,124.086486 C9.81235551,129.069593 27.8143393,134.0527 54.051273,136.352596 C54.434294,134.0527 54.6258044,131.752805 54.8173149,129.261251 C46.199344,123.511512 40.2625195,116.420167 36.0492893,109.137165 Z M9.42933458,130.411199 C11.1529288,132.519436 13.6425648,135.01099 16.8982427,137.310886 C23.2180881,141.910677 33.3681428,147.085442 49.2635114,150.343627 C51.1786161,147.2771 52.3276789,143.44394 53.2852312,139.419123 C34.9002265,137.885859 18.8133474,134.819332 9.42933458,130.411199 Z M83.9269057,159.926525 C104.610036,159.926525 114.760091,156.285024 119.739363,153.218497 C109.780818,155.326734 98.0986801,156.476682 83.9269057,156.476682 C70.5211731,156.476682 59.2220556,155.518392 49.6465323,153.601813 C49.4550219,153.793471 49.4550219,153.793471 49.2635114,153.985129 C54.2427835,156.66834 64.3928382,159.926525 83.9269057,159.926525 Z M151.5301,137.310886 C154.594267,135.01099 157.083903,132.711094 158.999008,130.602857 C144.252702,137.119228 113.802538,140.569071 84.5014371,140.569071 C74.7344033,140.569071 64.7758591,140.185755 55.3918463,139.419123 C54.434294,143.635598 53.2852312,147.468758 51.3701265,150.726943 C60.3711184,152.451865 71.0957045,153.410155 83.9269057,153.410155 C121.079936,153.410155 141.188535,144.785546 151.5301,137.310886 Z M113.228007,37.2654275 C111.887434,35.3488478 110.54686,33.2406102 110.163839,30.5573987 C109.780818,28.0658451 110.738371,25.5742916 112.653475,23.6577119 C113.611028,22.6994221 114.56858,22.1244482 115.526132,21.5494743 C116.292174,20.9745004 117.058216,20.3995265 117.824258,19.8245526 C119.930873,17.716315 119.547852,15.2247614 118.78181,13.4998397 C118.5903,12.9248658 118.207279,12.3498919 117.824258,11.966576 C116.866706,10.8166282 115.143112,7.55844281 118.207279,3.53362553 C119.739363,1.42538791 122.228999,0.658756046 125.293166,0.850414011 C129.314886,1.23372994 133.145095,3.7252835 134.677179,6.79181094 C136.209263,10.0499964 136.017752,14.0748136 134.294158,17.524657 C132.762074,20.3995265 130.272438,22.8910801 126.82525,25.1909756 C126.633739,25.3826336 126.250719,25.5742916 125.867698,25.7659495 C124.527124,26.7242394 123.378062,27.4908712 122.420509,28.4491611 C120.505405,30.3657407 120.122384,33.6239261 121.462957,35.9238217 C121.654467,36.3071376 122.037488,36.6904536 122.228999,37.0737695 C122.61202,37.8404014 122.995041,38.6070332 123.378062,39.3736651 C124.910145,43.5901403 122.037488,46.4650098 119.164831,48.9565634 C118.973321,49.1482213 118.78181,49.1482213 118.5903,49.1482213 C118.398789,49.1482213 118.015769,48.9565634 117.824258,48.7649054 C117.441237,48.1899315 117.632748,47.6149576 118.015769,47.2316417 C121.079936,44.5484302 122.61202,42.6318505 121.654467,39.756981 C121.462957,39.1820071 121.079936,38.6070332 120.696915,38.0320593 C120.505405,37.6487434 120.122384,37.0737695 119.930873,36.6904536 C118.207279,33.6239261 118.78181,29.5991089 121.079936,26.9158973 C122.037488,25.5742916 123.569572,24.6160017 124.910145,23.8493699 C125.293166,23.6577119 125.484677,23.466054 125.867698,23.274396 C128.931865,21.1661584 131.229991,18.8662628 132.570564,16.3747092 C134.102648,13.3081818 134.294158,10.0499964 132.953585,7.55844281 C131.613012,5.06688925 128.357334,3.1503096 125.101656,2.76699367 C123.761082,2.76699367 121.271446,2.76699367 119.739363,4.68357332 C117.441237,7.36678484 118.5903,9.66668043 119.356342,10.6249703 C119.739363,11.1999442 120.313894,11.966576 120.696915,12.7332079 C122.228999,15.9913933 121.654467,19.0579207 119.356342,21.3578163 C118.5903,22.1244482 117.632748,22.6994221 116.675195,23.274396 C115.717643,23.8493699 114.951601,24.2326858 114.185559,24.9993177 C112.844986,26.5325814 112.078944,28.4491611 112.270455,30.3657407 C112.653475,32.4739783 113.802538,34.1989 114.951601,36.1154797 C115.526132,37.0737695 115.909153,37.8404014 116.483685,38.7986912 C117.632748,41.0985868 119.930873,45.50672 116.100664,47.9982735 C115.717643,48.1899315 115.143112,48.1899315 114.760091,47.6149576 C114.56858,47.2316417 114.56858,46.6566678 115.143112,46.2733519 C116.866706,45.1234041 116.675195,43.3984824 114.760091,39.756981 C114.37707,38.9903492 113.802538,38.0320593 113.228007,37.2654275 Z M90.8212824,43.7817983 C90.4382615,43.7817983 90.0552405,43.5901403 90.0552405,43.3984824 C89.8637301,42.8235085 90.0552405,42.2485346 90.6297719,42.0568766 C90.6297719,42.0568766 96.1835754,39.756981 97.3326382,35.3488478 C97.9071696,33.0489522 97.1411278,30.7490566 95.2260231,28.2575031 C91.9703452,24.0410278 90.8212824,20.2078685 91.5873243,17.1413411 C92.1618557,14.2664716 94.4599813,12.158234 97.9071696,10.4333123 C98.481701,10.2416543 99.0562324,10.4333123 99.2477429,11.0082862 C99.4392534,11.5832601 99.2477429,12.158234 98.6732115,12.3498919 C95.8005545,13.6914977 94.0769603,15.4164194 93.5024289,17.524657 C92.7363871,20.0162106 93.8854499,23.274396 96.7581068,26.9158973 C99.0562324,29.9824248 99.8222743,32.8572943 99.0562324,35.7321638 C97.7156592,40.9069288 91.3958138,43.5901403 91.2043033,43.7817983 L90.8212824,43.7817983 Z M53.0937207,118.528405 C45.6248126,111.628718 38.3474149,97.8293446 36.8153311,85.5632348 C36.8153311,84.221629 37.9643939,83.2633392 39.3049672,83.6466551 C42.7521556,84.604945 49.0720009,86.3298667 53.4767416,86.7131826 C52.9022102,93.9961853 52.9022102,102.812452 53.0937207,110.862086 L53.0937207,118.528405 Z"
                let teaPath = UIBezierPath(pathString: tea)
                let returnView = UIView()
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = teaPath.cgPath
                returnView.layer.addSublayer(shapeLayer)
                return returnView
            })
        ]
        return returnData
    }()

}

extension GithubViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let returnCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GithubCell", for: indexPath) as? GithubCell
        let thisItem = self.collectionViewData[indexPath.row]
        returnCell?.svgView.addSubview(thisItem.render(returnCell!.bounds.size))
        return returnCell!
    }
    
}

extension GithubViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellDimension = collectionView.bounds.size.width * 0.45
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
}
