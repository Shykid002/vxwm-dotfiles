const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#1e160d", /* black   */
  [1] = "#304555", /* red     */
  [2] = "#30516C", /* green   */
  [3] = "#56565B", /* yellow  */
  [4] = "#976959", /* blue    */
  [5] = "#B78D73", /* magenta */
  [6] = "#47718B", /* cyan    */
  [7] = "#c6c4c2", /* white   */

  /* 8 bright colors */
  [8]  = "#70675c",  /* black   */
  [9]  = "#304555",  /* red     */
  [10] = "#30516C", /* green   */
  [11] = "#56565B", /* yellow  */
  [12] = "#976959", /* blue    */
  [13] = "#B78D73", /* magenta */
  [14] = "#47718B", /* cyan    */
  [15] = "#c6c4c2", /* white   */

  /* special colors */
  [256] = "#1e160d", /* background */
  [257] = "#c6c4c2", /* foreground */
  [258] = "#c6c4c2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
